package magicStone.components
{
   import ddt.data.goods.ItemTemplateInfo;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class EmbedMgStoneCell extends MgStoneCell
   {
       
      
      public function EmbedMgStoneCell(param1:int = 0, param2:ItemTemplateInfo = null, param3:Boolean = true, param4:DisplayObject = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function set info(param1:ItemTemplateInfo) : void
      {
         .super.info = param1;
         if(param1 && _nameTxt)
         {
            _nameTxt.x = -1;
            _nameTxt.y = 37;
            _nameTxt.width = 60;
            _nameTxt.height = 18;
            _nameTxt.filterString = "magicStone.mgStoneCell.nameGF2";
            _nameTxt.text = _info.Name.substr(0,2) + "Lv." + _info.Level;
            _nameTxt.textColor = getNameTxtColor(_info.Quality);
         }
      }
      
      private function getNameTxtColor(param1:int) : uint
      {
         switch(int(param1) - 1)
         {
            case 0:
               return 11655167;
            case 1:
               return 65280;
            case 2:
               return 57087;
            case 3:
               return 16729855;
            case 4:
               return 16771584;
            case 5:
               return 16711680;
         }
      }
      
      override protected function updateSize(param1:Sprite) : void
      {
         if(param1)
         {
            param1.scaleX = 0.7;
            param1.scaleY = 0.7;
            param1.x = param1.x - param1.width / 2 + _contentWidth / 2;
            param1.y = param1.y - param1.height / 2 + _contentHeight / 2;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
