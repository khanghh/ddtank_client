package tofflist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.tip.ITransformableTip;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class TofflistTitleInfoTip extends Sprite implements ITransformableTip
   {
       
      
      private var _bg:MutipleImage;
      
      private var _leftView:TofflistTitleInfoItem;
      
      private var _rightView:TofflistTitleInfoItem;
      
      public function TofflistTitleInfoTip()
      {
         super();
         initView();
         initData();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("tofflist.titleTips.bg");
         addChild(_bg);
         _leftView = new TofflistTitleInfoItem();
         addChild(_leftView);
         _rightView = new TofflistTitleInfoItem();
         PositionUtils.setPos(_rightView,"tofflist.tips.rightViewPos");
         addChild(_rightView);
      }
      
      private function initData() : void
      {
         var _loc1_:Object = {};
         _loc1_.titleText = LanguageMgr.GetTranslation("toffilist.titleInfo.rightTitleText");
         _loc1_.content = LanguageMgr.GetTranslation("toffilist.titleInfo.rightContentText");
         _loc1_.rightRequiredText = LanguageMgr.GetTranslation("toffilist.titleInfo.rightRequireText");
         _loc1_.title1 = "toffilist.titleInfo_TF8";
         _loc1_.title2 = "toffilist.titleInfo_TF9";
         _loc1_.title3 = "toffilist.titleInfo_TF10";
         _loc1_.title4 = "toffilist.titleInfo_TF11";
         _loc1_.titleName1 = LanguageMgr.GetTranslation("hall.player.titleText3");
         _loc1_.titleName2 = LanguageMgr.GetTranslation("hall.player.titleText4");
         _loc1_.titleName3 = LanguageMgr.GetTranslation("hall.player.titleText5");
         _loc1_.titleName4 = LanguageMgr.GetTranslation("hall.player.titleText6");
         _rightView.setData(_loc1_);
      }
      
      public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
      }
      
      public function get tipWidth() : int
      {
         return 0;
      }
      
      public function set tipWidth(param1:int) : void
      {
      }
      
      public function get tipHeight() : int
      {
         return 0;
      }
      
      public function set tipHeight(param1:int) : void
      {
      }
      
      public function get tipData() : Object
      {
         return null;
      }
      
      public function set tipData(param1:Object) : void
      {
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
   }
}
