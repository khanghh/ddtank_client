package ddt.view.rescue
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.ImgNumConverter;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RescueScoreAlertView extends Sprite implements Disposeable
   {
       
      
      private var _addBmp:Bitmap;
      
      private var _numSprite:Sprite;
      
      public function RescueScoreAlertView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _addBmp = ComponentFactory.Instance.creat("rescue.room.addIcon");
         addChild(_addBmp);
      }
      
      public function setData(param1:int) : void
      {
         ObjectUtils.disposeObject(_numSprite);
         _numSprite = null;
         _numSprite = ImgNumConverter.instance.convertToImg(param1,"rescue.room.num",11);
         PositionUtils.setPos(_numSprite,"rescue.numSpritePos");
         addChild(_numSprite);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_addBmp);
         _addBmp = null;
         ObjectUtils.disposeObject(_numSprite);
         _numSprite = null;
      }
   }
}
