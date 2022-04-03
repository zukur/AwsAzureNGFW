output "oobjumpbox_Administrator_Password" {
   value = rsadecrypt(aws_instance.oobjumpbox.password_data,file("bth.pem.prv"))
 }

 output "oobjumpbox_IP" {
   value = aws_instance.oobjumpbox.public_ip
 }

 output "jumpbox_Administrator_Password" {
   value = rsadecrypt(aws_instance.jumpbox.password_data,file("bth.pem.prv"))
 }

 output "ftdv01_IP" {
   value = aws_eip.ftdv01-eip.public_ip
 }

 output "fmc_IP" {
   value = aws_eip.fmc-eip.public_ip
 }