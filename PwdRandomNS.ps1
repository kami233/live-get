# ���������ַ���
$charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{};:,.<>/?".ToCharArray()

# ѭ����� 3 ���������
for ($i = 1; $i -le 3; $i++) {
    # ��ʼ������������ַ�������
    $password = @()
    $queue = New-Object System.Collections.ArrayList
    $queue.AddRange($charset)

    # ���ַ������������ѡ��һ���ַ���ֱ������ 16 �����ظ����ַ�Ϊֹ
    while ($password.Length -lt 16 -and $queue.Count -gt 0) {
        $index = Get-Random -Maximum $queue.Count
        
        # ��������Ƿ񳬹�������Ԫ������������
        if ($index -lt $queue.Count) {
            $char = $queue[$index]
            $password += $char

            # ���ַ�����ɾ����ѡ����ַ�
            $queue.RemoveAt($index)

            # �������Ԫ��Ϊ�գ������³�ʼ������
            if ($queue.Count -eq 0) {
                $queue.AddRange($charset)
            }
        }
    }

    # ������ɵ�����
    Write-Host "���� ${i}: $($password -join '')"
}


cmd /c "pause"