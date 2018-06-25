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
      
      public function addIcon(id:int) : void
      {
         if(_iconDic.hasKey(id))
         {
            return;
         }
         var icon:Image = StarlingMain.instance.createImage(PATH + id);
         if(_hBox)
         {
            _hBox.addElement(icon);
         }
         _iconDic.add(id,icon);
      }
      
      public function removeIcon(id:int) : void
      {
         var icon:* = null;
         if(_iconDic && _iconDic.hasKey(id))
         {
            icon = _iconDic[id] as Image;
            if(icon && _hBox)
            {
               _hBox.removeElement(icon,true);
            }
            _iconDic.remove(id);
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
