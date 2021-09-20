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
  1.1 <a href="#ALU">Arithmetic Logic Unit</a><br>
  1.2. <a href="#CU">Control Unit</a><br>
  1.3. <a href="#MEM">Memory</a><br>

## Components

### ALU

<div>
<img align="left" src="https://github.com/Matozinho/neander/blob/main/images/02-moduloULA.png" width=400>
</div>

the Arithmetic Logic Unit as the image on the left suggest has 3 main components, which are:

- **ALU (core)**: This component is capable of execute any logical or arithmetic, under NEANDER constraints. They are `ADD`, `NOT`, `OR`, `AND`, `STA`. Most of them can operate from two different sources `ADD`, `OR` and the `AND` operator extrictly both from the `AC` register and the data bus. `NOT` only operate data from the `AC` register and the `STA` only from the data bus. **Every ALU operation is stored under the `AC` register**.
- **AC**: Is the register to keep the operations data.
- **FLAGS**: As the name suggests is the FLAGS that points properties from the `AC` register current data.

### CU

### MEM
