package roomLoading.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class RoomLoadingTipsItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _txtField:FilterFrameText;
      
      public function RoomLoadingTipsItem()
      {
         super();
         init();
      }
      
      public function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.roomLoading.TipsItemBg");
         _txtField = ComponentFactory.Instance.creatComponentByStylename("roomLoading.TipsItemContentTxt");
         _txtField.text = LanguageMgr.GetTranslation("ddt.roomLoading.tips" + String(int(Math.random() * 3)));
         _txtField.x = (_bg.width - _txtField.textWidth) / 2 - 4;
         _txtField.y = (_bg.height - _txtField.textHeight) / 2 + 7;
         addChild(_bg);
         addChild(_txtField);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
