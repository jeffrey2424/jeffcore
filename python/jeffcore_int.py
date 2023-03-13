import argparse


def read_file(file_path: str) -> str:
    """Read a file, and return the text content
    """
    with open(file_path, "r") as f:
        contents = f.read()
    return contents

def split_contents_to_individual_commands(file_contents: str) -> list[str]:
    """
    """
    unclean_commands = file_contents.split(";")
    return [command.strip().lower() for command in unclean_commands if command.strip()]
    
def process_command(command, previous_val=None):
    command_split = command.split(' ')
    command_kw = command_split[0]
    try:
        command_val = int(command_split[1])
    except IndexError:
        pass
    except ValueError:
        raise(f"Cannot process value {command_split[1]}")
    
    if command_kw == "start":
        return command_val
    if command_kw == "add":
        return previous_val + command_val
    if command_kw == "sub":
        return previous_val - command_val
    if command_kw == "mul":
        return previous_val * command_val
    if command_kw == "div":
        return int(previous_val / command_val)
    if command_kw == "end":
        return previous_val
    
    raise ValueError(f"Keyword {command_kw} not valid")

def process_command_list(command_list):
    out_value = 0
    for command in command_list:
        out_value = process_command(command, out_value)
    return out_value


def main(filename):
    contents = read_file(filename)
    command_list = split_contents_to_individual_commands(contents)
    out = process_command_list(command_list)
    print(out)
    return out

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument("filename")
    args = parser.parse_args()

    main(args.filename)