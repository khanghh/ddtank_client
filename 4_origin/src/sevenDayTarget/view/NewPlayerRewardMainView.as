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
         var i:int = 0;
         var info:* = null;
         var item:* = null;
         var j:int = 0;
         var info1:* = null;
         var item1:* = null;
         var k:int = 0;
         var info2:* = null;
         var item2:* = null;
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
         var chongzhiInfoArr:Array = NewPlayerRewardManager.Instance.model.chongzhiInfoArr;
         for(i = 0; i < chongzhiInfoArr.length; )
         {
            info = chongzhiInfoArr[i];
            item = new NewPlayerRewardItem();
            item.setInfo(info);
            _vbox.addChild(item);
            i++;
         }
         _scrollpanel.setView(_vbox);
         _scrollpanel.invalidateViewport();
         addChild(_scrollpanel);
         _vbox2 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.xiaofeiVbox");
         _scrollpanel2 = ComponentFactory.Instance.creatComponentByStylename("newSevenDayAndNewPlayer.xiaofeiList");
         var xiaofeiInfoArr:Array = NewPlayerRewardManager.Instance.model.xiaofeiInfoArr;
         for(j = 0; j < xiaofeiInfoArr.length; )
         {
            info1 = xiaofeiInfoArr[j];
            item1 = new NewPlayerRewardItem();
            item1.setInfo(info1);
            _vbox2.addChild(item1);
            j++;
         }
         _scrollpanel2.setView(_vbox2);
         _scrollpanel2.invalidateViewport();
         addChild(_scrollpanel2);
         var hunliInfoArr:Array = NewPlayerRewardManager.Instance.model.hunliInfoArr;
         for(k = 0; k < hunliInfoArr.length; )
         {
            info2 = hunliInfoArr[k];
            item2 = new NewPlayerRewardItem();
            item2.setInfo(info2);
            addChild(item2);
            PositionUtils.setPos(item2,"newSevenDayAndNewPlayer.hunliListPos");
            k++;
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
      
      protected function __onHelpClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var helpView:SevenDayTargetHelpFrame = ComponentFactory.Instance.creat("sevenDayTarget.helpView");
         var helpInfo:MovieClip = ComponentFactory.Instance.creat("newPlayerReward.view.helpContentText");
         helpView.changeContent(helpInfo);
         LayerManager.Instance.addToLayer(helpView,0,true,1);
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
