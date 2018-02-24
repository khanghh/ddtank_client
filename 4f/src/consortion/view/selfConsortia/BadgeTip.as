package consortion.view.selfConsortia
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.ITip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.QualityType;
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class BadgeTip extends Sprite implements ITip, Disposeable
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line1:Image;
      
      private var _line2:Image;
      
      private var _nameTxt:FilterFrameText;
      
      private var _desTxt:FilterFrameText;
      
      private var _validDateTxt:FilterFrameText;
      
      private var _tipdata:Object;
      
      public function BadgeTip(){super();}
      
      public function get tipData() : Object{return null;}
      
      public function set tipData(param1:Object) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function dispose() : void{}
   }
}
