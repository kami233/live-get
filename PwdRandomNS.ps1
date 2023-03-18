# 定义密码字符集
$charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{};:,.<>/?".ToCharArray()

# 循环输出 3 个随机密码
for ($i = 1; $i -le 3; $i++) {
    # 初始化密码数组和字符集队列
    $password = @()
    $queue = New-Object System.Collections.ArrayList
    $queue.AddRange($charset)

    # 从字符集队列中随机选择一个字符，直到生成 16 个不重复的字符为止
    while ($password.Length -lt 16 -and $queue.Count -gt 0) {
        $index = Get-Random -Maximum $queue.Count
        
        # 检查索引是否超过队列中元素数量的上限
        if ($index -lt $queue.Count) {
            $char = $queue[$index]
            $password += $char

            # 从字符集中删除已选择的字符
            $queue.RemoveAt($index)

            # 如果队列元素为空，则重新初始化队列
            if ($queue.Count -eq 0) {
                $queue.AddRange($charset)
            }
        }
    }

    # 输出生成的密码
    Write-Host "密码 ${i}: $($password -join '')"
}


cmd /c "pause"