package com.finegamedesign.anagram
{
    import flash.utils.ByteArray;

    public class Words
    {
        [Embed(source="../../../../txt/word_list_moby_crossword.flat.txt", mimeType="application/octet-stream")]
        private var WordsClass:Class;
        internal var words:Object;

        public function init():Object
        {
            var text:String = String(new WordsClass() as ByteArray);
            var lines:Array = text.replace("\r\n", "\n").split("\n");
            var length:int = lines.length;
            words = {};
            for (var i:int = 0; i < length; i++)
            {
                words[lines[i]] = true;
            }
            return words;
        }
    }
}
