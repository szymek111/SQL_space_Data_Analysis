import codecs
import sys

if __name__ == "__main__":
    if len(sys.argv) != 5:
        print("Usage: python script.py <path_to_input_file> <path_to_output_file>")
    else:
        source_encoding = sys.argv[1]
        target_encoding = sys.argv[2]
        source_file_name = sys.argv[3]
        target_file_name = sys.argv[4]

def convert_to(source_encoding, target_encoding, source_file_name, target_file_name, blocksize=1048576):
    try:
        with codecs.open(source_file_name, "r", source_encoding) as source_file:
            with codecs.open(target_file_name, "w", target_encoding) as target_file:
                while True:
                    contents = source_file.read(blocksize)
                    if not contents:
                        break
                    target_file.write(contents)
        print(f"The file was successfully converted to UTF-8 and saved in: {target_file_name}.")
    
    except Exception as e:
        print(f"An error occurred during conversion: {e}")

convert_to(source_encoding, target_encoding, source_file_name, target_file_name)
