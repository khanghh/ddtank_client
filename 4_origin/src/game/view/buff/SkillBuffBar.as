package game.view.buff
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import road7th.data.DictionaryData;
   
   public class SkillBuffBar extends Sprite implements Disposeable
   {
      
      private static var PATH:String = "asset.game.skillBuff.icon";
       
      
      private var _iconDic:DictionaryData;
      
      private var _hBox:HBox;
      
      public function SkillBuffBar()
      {
         super();
         _iconDic = new DictionaryData();
         _hBox = ComponentFactory.Instance.creatComponentByStylename("game.skillBuff.iconHbox");
         addChild(_hBox);
      }
      
      public function addIcon(id:int) : void
      {
         if(_iconDic.hasKey(id))
         {
            return;
         }
         var _icon:Bitmap = ComponentFactory.Instance.creatBitmap(PATH + id);
         if(_hBox)
         {
            _hBox.addChild(_icon);
         }
         _iconDic.add(id,_icon);
      }
      
      public function removeIcon(id:int) : void
      {
         var icon:* = null;
         if(_iconDic && _iconDic.hasKey(id))
         {
            icon = _iconDic[id] as Bitmap;
            if(icon && _hBox)
            {
               _hBox.removeChild(icon);
               _hBox.arrange();
            }
            _iconDic.remove(id);
            icon.bitmapData.dispose();
            icon.bitmapData = null;
            icon = null;
         }
      }
      
      public function dispose() : void
      {
         if(_iconDic)
         {
            _iconDic.clear();
         }
         _iconDic = null;
         if(_hBox)
         {
            _hBox.removeAllChild();
         }
         _hBox = null;
      }
   }
}
