package sevenDayTarget.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import sevenDayTarget.controller.NewPlayerRewardManager;
   import sevenDayTarget.model.NewPlayerRewardInfo;
   
   public class NewPlayerRewardMainView extends Sprite
   {
      
      public static var CHONGZHI:int = 1;
      
      public static var XIAOFEI:int = 2;
      
      public static var HUNLI:int = 3;
       
      
      private var _bg:Bitmap;
      
      private var _downBack:ScaleBitmapImage;
      
      private var _titleText1:FilterFrameText;
      
      private var _titleText2:FilterFrameText;
      
      private var _titleText3:FilterFrameText;
      
      private var _scrollpanel:ScrollPanel;
      
      private var _scrollpanel2:ScrollPanel;
      
      private var _vbox:VBox;
      
      private var _vbox2:VBox;
      
      private var _helpBnt:BaseButton;
      
      public function NewPlayerRewardMainView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc12_:int = 0;
         var _loc11_:* = null;
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc2_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = null;
         var _loc1_:* = null;
         _bg = ComponentFactory.Instance.creat("sevenDay.newPlayerBg");
         _downBack = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.scale9cornerImageTree");
         _titleText1 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext1");
         _titleText2 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext2");
         _titleText3 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.titletext3");
         _titleText1.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.title1");
         _titleText2.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.title2");
         _titleText3.text = LanguageMgr.GetTranslation("newSevenDayAndNewPlayer.title3");
         addChild(_downBack);
         addChild(_bg);
         addChild(_titleText1);
         addChild(_titleText2);
         addChild(_titleText3);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.chongzhiVbox");
         _scrollpanel = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.chongzhiList");
         var _loc7_:Array = NewPlayerRewardManager.Instance.model.chongzhiInfoArr;
         _loc12_ = 0;
         while(_loc12_ < _loc7_.length)
         {
            _loc11_ = _loc7_[_loc12_];
            _loc5_ = new NewPlayerRewardItem();
            _loc5_.setInfo(_loc11_);
            _vbox.addChild(_loc5_);
            _loc12_++;
         }
         _scrollpanel.setView(_vbox);
         _scrollpanel.invalidateViewport();
         addChild(_scrollpanel);
         _vbox2 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.xiaofeiVbox");
         _scrollpanel2 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.xiaofeiList");
         var _loc3_:Array = NewPlayerRewardManager.Instance.model.xiaofeiInfoArr;
         _loc8_ = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc6_ = _loc3_[_loc8_];
            _loc2_ = new NewPlayerRewardItem();
            _loc2_.setInfo(_loc6_);
            _vbox2.addChild(_loc2_);
            _loc8_++;
         }
         _scrollpanel2.setView(_vbox2);
         _scrollpanel2.invalidateViewport();
         addChild(_scrollpanel2);
         var _loc4_:Array = NewPlayerRewardManager.Instance.model.hunliInfoArr;
         _loc9_ = 0;
         while(_loc9_ < _loc4_.length)
         {
            _loc10_ = _loc4_[_loc9_];
            _loc1_ = new NewPlayerRewardItem();
            _loc1_.setInfo(_loc10_);
            addChild(_loc1_);
            PositionUtils.setPos(_loc1_,"newSevenDayAndNewPlayer.hunliListPos");
            _loc9_++;
         }
         addHelpBnt();
      }
      
      private function addHelpBnt() : void
      {
         _helpBnt = ComponentFactory.Instance.creatComponentByStylename("newPlayerReward.helpBnt");
         addChild(_helpBnt);
         PositionUtils.setPos(_helpBnt,"newPlayerReward.view.helpBntPos");
         _helpBnt.addEventListener("click",__onHelpClick);
      }
      
      protected function __onHelpClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc3_:SevenDayTargetHelpFrame = ComponentFactory.Instance.creat("sevenDayTarget.helpView");
         var _loc2_:MovieClip = ComponentFactory.Instance.creat("newPlayerReward.view.helpContentText");
         _loc3_.changeContent(_loc2_);
         LayerManager.Instance.addToLayer(_loc3_,0,true,1);
      }
      
      private function initEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function dispose() : void
      {
      }
   }
}
