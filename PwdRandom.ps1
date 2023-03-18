# 定义密码字符集
$charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+-=[]{};:,.<>/?".ToCharArray()

# 定义用于存储已生成的密码的哈希表
$seenPasswords = @{}

# 循环输出 3 个随机密码
for ($i = 1; $i -le 3; $i++) {
    # 生成随机密码，直到生成未出现过的密码为止
    do {
        $password = ""
        for ($j = 1; $j -le 16; $j++) {
            $password += $charset[(Get-Random -Minimum 0 -Maximum $charset.Length)]
        }
    } while ($seenPasswords.Contains($password))

    # 将新生成的密码添加到哈希表中
    $seenPasswords.Add($password, $true)

    # 输出生成的密码
    Write-Host "密码 ${i}: ${password}"
}
cmd /c "pause"