# This is a sample Python script.

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.

def gen_code_0():
    line_template = "if (wr_in && cs_{0:03x}) reg_{0:03x} <= data_in;\n"
    with open("gen_code_0.txt", "w") as f:
        for n in range(0x150, 0x250, 4):
            f.write(line_template.format(n))


def gen_code_1():
    line_template = "parameter const_{0:03x} = 12'h{0:03X};\n"
    with open("gen_code_1.txt", "w") as f:
        for n in range(0x80, 0x140, 4):
            f.write(line_template.format(n))


def gen_code_2():
    line_template = "wire cs_{0:03x} = (addr_in[11:2]==const_{0:03x}[11:2])? 1'b1: 1'b0;\n"
    with open("gen_code_2.txt", "w") as f:
        for n in range(0x80, 0x140, 4):
            f.write(line_template.format(n))


def gen_code_3():
    line_template = "{0}[{1}]=8'h00; "
    with open("gen_code_3.txt", "w") as f:
        for n in range(0, 60):
            f.write(line_template.format("packet", n))
            if n % 4 == 3:
                f.write("\n")


def gen_code_4():
    line_template = \
        "assign m_axis_{0}_{1}_tdata     = fifo_out_tdata[{2}];\n" + \
        "assign m_axis_{0}_{1}_tkeep     = fifo_out_tkeep[{2}];\n" + \
        "assign m_axis_{0}_{1}_tuser     = fifo_out_tuser[{2}];\n" + \
        "assign m_axis_{0}_{1}_tlast     = fifo_out_tlast[{2}];\n" + \
        "assign m_axis_{0}_{1}_tvalid    = ~empty[{2}];\n" + \
        "assign rd_en[{2}]             = m_axis_{0}_{1}_tready & ~empty[{2}];\n\n"
    with open("gen_code_4.txt", "w") as f:
        for i in range(4):
            for j in range(8):
                k = i * 8 + j
                f.write(line_template.format(i, j, k))


def gen_code_5():
    line_template = ".m_axis_{0}_{1}_tdata(m_axis_{0}_{1}_tdata),\n" + \
                    ".m_axis_{0}_{1}_tkeep(m_axis_{0}_{1}_tkeep),\n" + \
                    ".m_axis_{0}_{1}_tuser(m_axis_{0}_{1}_tuser),\n" + \
                    ".m_axis_{0}_{1}_tvalid(m_axis_{0}_{1}_tvalid),\n" + \
                    ".m_axis_{0}_{1}_tready(m_axis_{0}_{1}_tready),\n" + \
                    ".m_axis_{0}_{1}_tlast(m_axis_{0}_{1}_tlast),\n"
    with open("gen_code_5.txt", "w") as f:
        for i in range(4):
            for j in range(8):
                f.write(line_template.format(i, j))


def gen_code_6():
    line_template = \
        "assign m_axis_{0}_{1}_tdata         = int_m_axis_tdata[{0}][{1}];\n" + \
        "assign m_axis_{0}_{1}_tkeep         = int_m_axis_tkeep[{0}][{1}];\n" + \
        "assign m_axis_{0}_{1}_tuser         = int_m_axis_tuser[{0}][{1}];\n" + \
        "assign m_axis_{0}_{1}_tvalid        = int_m_axis_tvalid[{0}][{1}];\n" + \
        "assign m_axis_{0}_{1}_tlast         = int_m_axis_tlast[{0}][{1}];\n" + \
        "assign int_m_axis_tready[{0}][{1}]  = m_axis_{0}_{1}_tready;\n\n"

    with open("gen_code_6.txt", "w") as f:
        for i in range(4):
            for j in range(8):
                k = i * 8 + j
                f.write(line_template.format(i, j, k))

def gen_code_7():
    line_template = "parameter const_{0:03x} = 12'h{0:03X};\n"
    with open("gen_code_7.txt", "w") as f:
        x = 0x150
        n = 0
        while(True):
            if n == 68:
                break
            f.write(line_template.format(x))
            x = x + 4
            n = n + 1
        # for n in range(0x14c, 0x140, 4):
        #     f.write(line_template.format(n))
def gen_code_8():
    line_template = "wire cs_{0:03x} = (addr_in[11:2]==const_{0:03x}[11:2])? 1'b1: 1'b0;\n"
    with open("gen_code_8.txt", "w") as f:
        x = 0x150
        n = 0
        while(True):
            if n == 64:
                break
            f.write(line_template.format(x))
            x = x + 4
            n = n + 1

def gen_code_9():
    line_template = "reg [31:0] reg_{0:03x};\n"
    with open("gen_code_9.txt", "w") as f:
        x = 0x150
        n = 0
        while(True):
            if n == 64:
                break
            f.write(line_template.format(x))
            x = x + 4
            n = n + 1

def gen_code_10():
    line_template = "if (rd_in && cs_{0:03x}) data_out_reg <=  {23'd0, gcl_data_in_flat[{}:{}]};\n"
    with open("gen_code_10.txt", "w") as f:
        x = 0x150
        n = 0
        while(True):
            if n == 64:
                break
            f.write(line_template.format(x))
            x = x + 4
            n = n + 1



def print_hi(name):
    # Use a breakpoint in the code line below to debug your script.
    print(f'Hi, {name}')  # Press Ctrl+F8 to toggle the breakpoint.


# Press the green button in the gutter to run the script.
if __name__ == '__main__':
    # print_hi('PyCharm')
    # gen_code_0()
    # gen_code_6()
    gen_code_7()
    # gen_code_8()
    # gen_code_10()

# See PyCharm help at https://www.jetbrains.com/help/pycharm/
