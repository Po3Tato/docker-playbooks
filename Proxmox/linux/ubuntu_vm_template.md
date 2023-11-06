# Creating Templates with Cloud-Init

## Steps

1. **Prepare the Virtual Machine:**
   - Follow the normal steps to create a VM.
   - Skip choosing an ISO by selecting "no disk."
   - Delete the storage location.
   - Set the CPU and RAM to your desired specifications (this can be changed later when deploying the VM).

2. **Configure Cloud-Init:**
   - Go to the Hardware tab and add a Cloud-Init Drive.
   - In the Cloud-Init section, enter the user and password details, and set the IP configuration to DHCP to ensure each VM gets a new IP.

3. **Download the Cloud Image:**
   - SSH into the Proxmox node.
   - Download the cloud image using the command below (we are using the Ubuntu 22.04 LTS Jammy release):

     ```bash
     wget https://cloud-images.ubuntu.com/minimal/releases/jammy/release/ubuntu-22.04-minimal-cloudimg-amd64.img
     ```
     > Note: While this link is for the Ubuntu 22.04 LTS image, any cloud image can be used.

4. **Prepare the Server View:**
   - Execute the following command to configure server view post-creation (replace `***` with the created VM ID):

     ```bash
     qm set *** --serial0 socket --vga serial0
     ```

5. **Rename and Resize the Image:**
   - Rename the downloaded image (ubuntu-22.04) and set the storage using these commands:

     ```bash
     mv ubuntu-22.04-minimal-cloudimg-amd64.img ubuntu-22.04.qcow2
     qemu-img resize ubuntu-22.04.qcow2 40G
     ```
     > This resizes the image to create a 40GB drive for each VM.

6. **Import the Disk:**
   - Import the disk to the VM ID and specify the storage location such as "local-lvm":

     ```bash
     qm importdisk 999 ubuntu-22.04.qcow2 local-lvm
     ```

7. **Finalize VM Configuration:**
   - In the Proxmox web GUI, enable the newly created unused disk. If it's an SSD, select Discard and SSD emulation, then add it.
   - Change the boot order in options since the new disk will not be primary by default.
   - **Verify that everything is configured correctly**.
   - Convert the VM to a template.

## Post-Installation Commands

After installing the VM, you'll need to set up and verify the QEMU agent:

1. **Install the QEMU Agent:**
   - To get the QEMU agent to work, install it using the following command:

     ```bash
     sudo apt install qemu-guest-agent -y
     ```
     > This allows you to control the VM from the Proxmox GUI for actions like rebooting or shutting it down.

2. **Reboot the VM:**
   - Reboot your VM to start the QEMU agent service.

3. **Verify the QEMU Agent Service:**
   - Check if the QEMU agent is running with this command:

     ```bash
     systemctl status qemu-guest-agent
     ```

