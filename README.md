# <h1 align="center">NEANDER</h1>

> Project developed for the class of Digital System lectured by @Edmar-Bellorini by the students @Daniel-Boll @Felipi-Matozinho @Pablo-Hugen which compose the super team BDT (CFDT).

---

<div>
  <img align="right" src="https://github.com/Matozinho/neander/blob/main/images/NEANDER_logo.png" width=240>

  
  NEANDER is a computer architecture based on a 1945 description by John von Neumann and others in the First Draft of a Report on the EDVAC. That document describes a design architecture for an electronic digital computer with these components: 
  - A processing unit that contains an arithmetic logic unit and processor registers
  - A control unit that contains an instruction register and program counter
  - Memory that stores data and instructions
  - External mass storage
  - Input and output mechanisms
</div>

---

1. <a href="Components">Components</a><br>
  1.1. <a href="#ALU">Arithmetic Logic Unit</a><br>
  1.2. <a href="#CU">Control Unit</a><br>
  1.3. <a href="#MEM">Memory</a><br>
2. <a href="Adaptions">Adaptions</a><br>
  2.1. <a href="JN and JZ">JN and JZ</a><br>

## Components

### ALU

<div>
<img align="left" src="https://github.com/Matozinho/neander/blob/main/images/02-moduloULA.png" width=350>
</div>

The Arithmetic Logic Unit as the image on the left suggest has 3 main components, which are:

<div>
<img align="right" src="https://github.com/Matozinho/neander/blob/main/images/ULACore.png" width=250>
</div>

- **ALU (core)**: This component is capable of execute any logical or arithmetic, under NEANDER constraints. They are `ADD`, `NOT`, `OR`, `AND`, `LDA`. Most of them can operate from two different sources `ADD`, `OR` and the `AND` operator extrictly both from the `AC` register and the data bus. `NOT` only operate data from the `AC` register and the `LDA` only from the data bus. **Every ALU operation is stored under the `AC` register**.
- **AC**: Is the register to keep the operations data.
- **FLAGS**: As the name suggests is the FLAGS that points properties from the `AC` register current data.

### MEM

<div>
<img align="left" src="https://github.com/Matozinho/neander/blob/main/images/03-moduloMEM.png" width=350>
</div>

The Memory Unit has 4 components, which are:

- **MUX 2x8**: This mux selects if the address that will be sent to `MAR` (Memory Address Register) is comming from the `PC` (Program Counter) or the data bus. 
- **MAR**: Store the address received from the previous MUX an sent it to the `RAM` (Random Access Memory).
- **RAM**: Is a memory of 256 bytes. On the read mode the memory will store in the `MDR` the data equivalent of the address passed from the `MAR`, otherwise in the write mode the memory will store on the address available in `MAR` the data comming from the data bus.
- **MDR/MBR**: Both the `MDR` and the data bus will receive the data from the `RAM` if it's in the read mode.

### CU

<div>
<img align="left" src="https://github.com/Matozinho/neander/blob/main/images/04-modulosControle-RI.png" width=150>
</div>

The Control Unit is responsible for handling all the instructions related logic, like decoding and storing a instruction. It is divided in 4 main submodules

- **CU** (Core): As the NEANDER is 8 clock-cycle-based all instructions will have the same time to execute, even though it don't need to make actions up until the cycle end. For every instruction the 3 firsts pulses are dedicated for searching the instruction and the increment of the `PC`. What the other 5 pulses does is trivial and it's up to the reader.   
- **PC** (Program Counter): Stores the address of the next instruction to be executed. The only way of changing it is via jump instructions (`JMP`, `JN` or `JZ`).
- **IR** (Instruction Register): Contains the current instruction data.
- **Decoder**: Output the instruction in a format like `8 bits` in -> `11 bits` out. From those 8 bits that enters, actually only 4 MSbits are used.

## Adaptions

### JN and JZ

As no documentation on how to implent the jumps `JN` (Jump if Negative) and `JZ` (Jump if Zero) was provided we decided to adapt it using a MUX2x11 that when the selector is `'1'` the output is equivalent of a normal `JMP` otherwise the output will be equivalent as a `NOP`. 
