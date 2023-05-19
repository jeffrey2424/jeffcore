import argparse
from typing import List
from string import Template
from config_template import OUTPUT_TEMPLATE

def read_file(file_path: str) -> str:
    """Read a file, and return the text content
    """
    with open(file_path, "r") as f:
        contents = f.read()
    return contents

def split_contents_to_individual_commands(file_contents: str) -> List[str]:
    """
    """
    unclean_commands = file_contents.split(";")
    return [command.strip().lower() for command in unclean_commands if command.strip()]
    

class CommandGen:
    def __init__(self, command):
        self.raw_command = command
        self.command_split = self.raw_command.split(' ')
        self.command_kw = self.command_split[0]
        try:
            self.command_val = int(self.command_split[1])
        except IndexError:
            pass
        except ValueError:
            raise(f"Cannot process value {self.command_split[1]}")
        
        self.pop = "\tpop rax\n"
        self.push = "\tpush rax\n"
    
    def generate(self):
        if self.command_kw=="start":
            return self.start()
        if self.command_kw=="add":
            return self.add()
        if self.command_kw=="sub":
            return self.sub()
        if self.command_kw=="mul":
            return self.mul()
        if self.command_kw=="div":
            return self.div()
        if self.command_kw=="end":
            return self.end()
        else:
            raise ValueError(f"Cannot process value {self.command_split[1]}")
    
    def start(self):
        comment = f"\n\t; start {self.command_val}\n"
        command_asm = f"\tmov rax, {self.command_val}\n"
        return comment + command_asm + self.push

    def add(self):
        comment = f"\n\t; add {self.command_val}\n"
        command_asm = f"\tadd rax, {self.command_val}\n"
        return comment + self.pop + command_asm + self.push
    
    def sub(self):
        comment = f"\n\t; subtract {self.command_val}\n"
        command_asm = f"\tsub rax, {self.command_val}\n"
        return comment + self.pop + command_asm + self.push
    
    def mul(self):
        comment = f"\n\t; multiply {self.command_val}\n"
        command_asm = f"\timul rax, {self.command_val}\n"
        return comment + self.pop + command_asm + self.push

    def div(self):
        comment = f"\n\t; divide {self.command_val}\n"
        command_asm = f"\tcqo\n\tmov rbx, {self.command_val}\n\tidiv rbx\n"
        return comment + self.pop + command_asm + self.push
    
    def end(self):
        comment = "\n\t; End of script\n"
        command_asm = "\tcall _printInt\n"
        return comment + command_asm



def process_command_list(command_list: List[str]) -> str:
    processed_list = [CommandGen(command).generate() for command in command_list]
    return ''.join(processed_list)


def populate_template(
        processed_comands: str,
        output_file: str
    ) -> str:
    template_string = Template(OUTPUT_TEMPLATE)
    process_command_dict = {"CONFIGURED_COMMANDS": processed_comands}
    populated_template = template_string.substitute(process_command_dict)

    with open(output_file, "w") as f:
        f.write(populated_template)
    return populated_template

def confirm_output(filename, output_dir):
    if output_dir:
        partial_filename = filename.split("/")[-1].split(".")[0] + ".asm"
        if output_dir[-1] != "/":
            output_dir += "/"
        return output_dir + partial_filename
    
    return filename.split(".")[0] + ".asm"



def main(filename, output_dir):
    output_filename = confirm_output(filename, output_dir)

    contents = read_file(filename)
    command_list = split_contents_to_individual_commands(contents)
    processed_commands = process_command_list(command_list)
    populated_template = populate_template(processed_commands, output_filename)
    print(f"Successpully compiled code to assmebly, at path: {output_filename}")
    return populated_template

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("filename")
    parser.add_argument("--output", "-o", required=False)
    args = parser.parse_args()

    main(args.filename, args.output)