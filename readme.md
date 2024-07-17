Desafio 11 de Bootcamp Devops


1. Preparación en tu PC:
   - Crea una carpeta llamada "Proyecto" en el mismo directorio donde está tu Vagrantfile.
   - Coloca los archivos main.tf, inventory.yaml y playbook.yaml en esta carpeta "Proyecto".

2. Iniciar y acceder a la VM:
   ```
   vagrant up
   vagrant ssh
   ```

3. Dentro de la VM, accede al directorio compartido:
   ```
   cd /vagrant/Proyecto
   ```

4. Configurar y ejecutar Terraform:
   ```
   terraform init
   terraform apply
   ```
   Confirma con "yes" cuando se te solicite.
   Anota la IP pública que se muestra como output.

5. Actualizar el inventario de Ansible:
   ```
   sudo nano inventory.yaml
   ```
   - Reemplaza `<IP_PUBLICA_DE_TU_INSTANCIA>` con la IP real.
   - Asegúrate de que la ruta de la clave privada sea correcta (probablemente `/vagrant/Proyecto/terraform-key.pem`).
   - Guarda y cierra el archivo (Ctrl+X, luego Y, luego Enter).

6. Realizar un ping con Ansible:
   ```
    ansible all -i inventory.yaml -m ping
   ```

7. Ejecutar el playbook de Ansible:
   ```
   ansible-playbook -i inventory.yaml playbook.yaml
   ```

8. Verificar el servidor web:
   - Abre un navegador en tu PC y visita la IP pública de tu instancia EC2.

9. Limpieza:
   - Para destruir los recursos en AWS:
     ```
     terraform destroy
     ```
   - Confirma con "yes" cuando se te solicite.

10. Salir y apagar la VM:
   ```
   exit
   vagrant halt
   ```
