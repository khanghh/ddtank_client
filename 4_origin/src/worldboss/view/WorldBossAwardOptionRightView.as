package worldboss.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.events.PlayerPropertyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import worldboss.WorldBossManager;
   import worldboss.event.WorldBossRoomEvent;
   
   public class WorldBossAwardOptionRightView extends Sprite implements Disposeable
   {
       
      
      private var _rightViewBg:MovieImage;
      
      private var _rightViewBg1:MutipleImage;
      
      private var _rightViewBg2:MutipleImage;
      
      private var _listView:WorldBossAwardListView;
      
      private var _pointBg:Bitmap;
      
      private var _pointInputBg:Scale9CornerImage;
      
      private var _pointTable:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _btnGoback:BaseButton;
      
      private var _btnEnter:BaseButton;
      
      private var _titlebg:MutipleImage;
      
      public function WorldBossAwardOptionRightView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _rightViewBg = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG1");
         addChild(_rightViewBg);
         _rightViewBg1 = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG2");
         addChild(_rightViewBg1);
         _rightViewBg2 = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG3");
         addChild(_rightViewBg2);
         _titlebg = ComponentFactory.Instance.creatComponentByStylename("asset.worldbossAwardRoom.rightBg");
         addChild(_titlebg);
         _pointBg = ComponentFactory.Instance.creatBitmap("asset.ddtlittleGame.pointbg");
         addChild(_pointBg);
         _pointInputBg = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG4");
         addChild(_pointInputBg);
         _pointTable = ComponentFactory.Instance.creatComponentByStylename("littleGame.MypointTxt");
         addChild(_pointTable);
         _pointTable.text = LanguageMgr.GetTranslation("ddtlittlegame.HaveAwardScore");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("littleGame.pointTxt");
         addChild(_pointTxt);
         _pointTxt.text = PlayerManager.Instance.Self.damageScores.toString();
         _btnGoback = ComponentFactory.Instance.creatComponentByStylename("littleGame.btnGobackHot");
         addChild(_btnGoback);
         _btnEnter = ComponentFactory.Instance.creatComponentByStylename("littleGame.btnEnterGame");
         addChild(_btnEnter);
         if(WorldBossManager.Instance.bossInfo.roomClose)
         {
            _btnEnter.enable = false;
         }
         _listView = ComponentFactory.Instance.creatCustomObject("worldbossAwardRoom.awardList");
         addChild(_listView);
      }
      
      private function addEvent() : void
      {
         _btnGoback.addEventListener("click",__btnGobackClick);
         _btnEnter.addEventListener("click",__btnEnterClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",onChange);
         WorldBossManager.Instance.addEventListener("room close",__roomclose);
      }
      
      private function onChange(param1:PlayerPropertyEvent) : void
      {
         _pointTxt.text = PlayerManager.Instance.Self.damageScores.toString();
      }
      
      private function __btnGobackClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("close"));
         StateManager.setState("main");
      }
      
      private function __btnEnterClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         WorldBossManager.Instance.show();
      }
      
      private function removeEvent() : void
      {
         _btnGoback.removeEventListener("click",__btnGobackClick);
         _btnEnter.removeEventListener("click",__btnEnterClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",onChange);
         WorldBossManager.Instance.removeEventListener("room close",__roomclose);
      }
      
      private function __roomclose(param1:WorldBossRoomEvent) : void
      {
         _btnEnter.enable = false;
         _listView.updata();
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
