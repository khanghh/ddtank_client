package dice.vo
{
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   
   public class DiceAwardInfo
   {
       
      
      private var _level:int;
      
      private var _integral:int;
      
      private var _templateInfo:Vector.<DiceAwardCell>;
      
      public function DiceAwardInfo($level:int, $integral:int, $templateString:String)
      {
         super();
         _templateInfo = new Vector.<DiceAwardCell>();
         _level = $level;
         _integral = $integral;
         setTemplateInfo = $templateString;
      }
      
      public function get level() : int
      {
         return _level;
      }
      
      public function get integral() : int
      {
         return _integral;
      }
      
      public function get templateInfo() : Vector.<DiceAwardCell>
      {
         return _templateInfo;
      }
      
      private function set setTemplateInfo(templateString:String) : void
      {
         var cell:* = null;
         var info:* = null;
         var bg:* = null;
         var str:* = null;
         var i:int = 0;
         if(templateString == null || templateString == "")
         {
            return;
         }
         var arr:Array = templateString.split(",");
         for(i = arr.length; i > 0; )
         {
            str = arr[i - 1];
            if(str != null && str != "")
            {
               info = ItemManager.Instance.getTemplateById(int(str.split("|")[0]));
               cell = new DiceAwardCell(info,int(str.split("|")[1]));
               _templateInfo.push(cell);
            }
            i--;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         for(i = _templateInfo.length; i > 0; )
         {
            if(_templateInfo[i - 1])
            {
               _templateInfo[i - 1].dispose();
               _templateInfo[i - 1] = null;
            }
            i--;
         }
         _templateInfo = null;
      }
   }
}
