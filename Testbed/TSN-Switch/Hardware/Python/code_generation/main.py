def gen1():
    with open("code/gen1.v", "w") as f:
        for i in range(32):
            f.write("output reg [47:0] dst_mac_{},\n", i)
            f.write("output reg [7:0] dst_port_{},\n", i)


if __name__ == "__main__":
    gen1()
