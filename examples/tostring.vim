exec 'so '.expand('<sfile>:h').'/../xmlparse.vim'

function! s:dump(node, indent)
  echo repeat(' ',a:indent).a:node.name
  for attr in keys(a:node.attr)
    echo repeat(' ',a:indent + 2).'* '.attr.'='.a:node.attr[attr]
  endfor
  for child in a:node.child
    call s:dump(child, a:indent + 4)
  endfor
  if len(a:node.value)
    echo repeat(' ',a:indent + 2).'- '.substitute(string(a:node.value), '\n', '\\n', 'g')
  endif
endfunction

let xml = join(filter(split(substitute(join(readfile(expand('<sfile>')), "\n"), '.*\nfinish\n', '', ''), '\n', 1), "v:val !~ '^\"'"), "\n")
silent unlet! doc
let doc = ParseXml(xml)
call s:dump(doc.find("\x95\x94\x97\xde"), 0)

finish
<?xml encoding="utf-8" ?>
<くだもの>
	<部類>
	<みかん 種類="ミカン科1" 産地="和歌山1">
	</みかん>
		<みかん 種類="ミカン科2" 産地="和歌山2">ミカン</みかん>
	<りんご 種類="りんご科" 産地="和歌山"/>
	<りんご 種類="りんご科" 産地="和歌山"/>
	<バナナ 種類="バショウ科" 産地="フィリピン">まるごと&amp;バナナ美味しいよ</バナナ>
	バショウ
	</部類>
</くだもの>
