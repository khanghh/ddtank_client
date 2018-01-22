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
      
      public function addIcon(param1:int) : void
      {
         if(_iconDic.hasKey(param1))
         {
            return;
         }
         var _loc2_:Bitmap = ComponentFactory.Instance.creatBitmap(PATH + param1);
         if(_hBox)
         {
            _hBox.addChild(_loc2_);
         }
         _iconDic.add(param1,_loc2_);
      }
      
      public function removeIcon(param1:int) : void
      {
         var _loc2_:* = null;
         if(_iconDic && _iconDic.hasKey(param1))
         {
            _loc2_ = _iconDic[param1] as Bitmap;
            if(_loc2_ && _hBox)
            {
               _hBox.removeChild(_loc2_);
               _hBox.arrange();
            }
            _iconDic.remove(param1);
            _loc2_.bitmapData.dispose();
            _loc2_.bitmapData = null;
            _loc2_ = null;
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
