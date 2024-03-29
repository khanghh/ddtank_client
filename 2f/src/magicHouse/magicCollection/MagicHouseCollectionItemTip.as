package magicHouse.magicCollection
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.tip.BaseTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   
   public class MagicHouseCollectionItemTip extends BaseTip
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _line:ScaleBitmapImage;
      
      private var _titleTxt:FilterFrameText;
      
      private var _typeNameTxt:FilterFrameText;
      
      private var _typeValueTxt:FilterFrameText;
      
      private var _activityStatusTxt:FilterFrameText;
      
      private var _detailTxt:FilterFrameText;
      
      private var _placeTxt:FilterFrameText;
      
      private var _activityTxt:FilterFrameText;
      
      private var _notActivityTxt:FilterFrameText;
      
      public function MagicHouseCollectionItemTip(){super();}
      
      override protected function init() : void{}
      
      override public function set tipData(param1:Object) : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function get height() : Number{return 0;}
      
      override public function dispose() : void{}
   }
}
