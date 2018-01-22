package gameStarling.view.buff
{
   import road7th.StarlingMain;
   import road7th.data.DictionaryData;
   import starling.display.Image;
   import starling.display.Sprite;
   import starlingui.core.components.HBox;
   
   public class SkillBuffBar3D extends Sprite
   {
      
      private static var PATH:String = "game_skillBuff_icon";
       
      
      private var _iconDic:DictionaryData;
      
      private var _hBox:HBox;
      
      public function SkillBuffBar3D()
      {
         super();
         _iconDic = new DictionaryData();
         _hBox = new HBox();
         _hBox.align = "middle";
         _hBox.space = 4;
         addChild(_hBox);
      }
      
      public function addIcon(param1:int) : void
      {
         if(_iconDic.hasKey(param1))
         {
            return;
         }
         var _loc2_:Image = StarlingMain.instance.createImage(PATH + param1);
         if(_hBox)
         {
            _hBox.addElement(_loc2_);
         }
         _iconDic.add(param1,_loc2_);
      }
      
      public function removeIcon(param1:int) : void
      {
         var _loc2_:* = null;
         if(_iconDic && _iconDic.hasKey(param1))
         {
            _loc2_ = _iconDic[param1] as Image;
            if(_loc2_ && _hBox)
            {
               _hBox.removeElement(_loc2_,true);
            }
            _iconDic.remove(param1);
         }
      }
      
      override public function dispose() : void
      {
         if(_iconDic)
         {
            _iconDic.clear();
         }
         _iconDic = null;
         if(_hBox)
         {
            _hBox.removeAllChild(null,true);
         }
         _hBox = null;
         super.dispose();
      }
   }
}
