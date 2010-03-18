exec 'so '.expand('<sfile>:h').'/../xmlparse.vim'
scriptencoding utf-8

function! s:dump(node, indent)
  if type(a:node) == 1
    let value = a:node
	let value = substitute(value, "\n", '\\n', 'g')
	let value = substitute(value, "\t", '\\t', 'g')
	let value = substitute(value, '"', '\"', 'g')
    echo repeat(' ',a:indent).'"'.value.'"'
  elseif type(a:node) == 3
    for n in a:node
	  call s:dump(n, a:indent)
    endfor
    return
  elseif type(a:node) == 4
    echo repeat(' ',a:indent).a:node.name
    for attr in keys(a:node.attr)
      echo repeat(' ',a:indent + 2).'* '.attr.'='.a:node.attr[attr]
    endfor
    for c in a:node.child
      call s:dump(c, a:indent + 4)
      unlet c
    endfor
  endif
endfunction

let xml = join(filter(split(substitute(join(readfile(expand('<sfile>')), "\n"), '.*\nfinish\n', '', ''), '\n', 1), "v:val !~ '^\"'"), "\n")
silent unlet! doc
let doc = ParseXml(xml)
call s:dump(doc.find("����").find("�݂���"), 0)
call s:dump(doc.find("����").findAll("�݂���"), 0)
call s:dump(doc.find("����").findAll("���"), 0)
call s:dump(doc, 0)

finish
<?xml encoding="utf-8" ?>
<��������>
	<����>
	<�݂��� ���="�~�J����1" �Y�n="�a�̎R1">
		<�݂��� ���="�~�J����2" �Y�n="�a�̎R2">
			<�݂��� ���="�~�J����3" �Y�n="�a�̎R3">�~�J��</�݂���>
		</�݂���>
	</�݂���>
	<��� ���="��񂲉�" �Y�n="�a�̎R"/>
	<��� ���="��񂲉�" �Y�n="�a�̎R"/>
	<�o�i�i ���="�o�V���E��" �Y�n="�t�B���s��">�܂邲��&amp;�o�i�i����������</�o�i�i>
	�o�V���E
	</����>
</��������>
