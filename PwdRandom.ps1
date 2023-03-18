# ���������ַ���
$charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{};:,.<>/?".ToCharArray()

# �������ڴ洢�����ɵ�����Ĺ�ϣ��
$seenPasswords = @{}

# ѭ����� 3 ���������
for ($i = 1; $i -le 3; $i++) {
    # ����������룬ֱ������δ���ֹ�������Ϊֹ
    do {
        $password = ""
        for ($j = 1; $j -le 16; $j++) {
            $password += $charset[(Get-Random -Minimum 0 -Maximum $charset.Length)]
        }
    } while ($seenPasswords.Contains($password))

    # �������ɵ�������ӵ���ϣ����
    $seenPasswords.Add($password, $true)

    # ������ɵ�����
    Write-Host "���� ${i}: ${password}"
}
cmd /c "pause"