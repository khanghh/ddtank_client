package littleGame.view
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
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import littleGame.LittleGameManager;
   
   public class OptionRightView extends Sprite implements Disposeable
   {
       
      
      private var _rightViewBg:MovieImage;
      
      private var _rightViewBg1:MutipleImage;
      
      private var _rightViewBg2:MutipleImage;
      
      private var _listView:LittleAwardListView;
      
      private var _pointBg:Bitmap;
      
      private var _pointInputBg:Scale9CornerImage;
      
      private var _pointTable:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _btnGoback:BaseButton;
      
      private var _btnEnter:BaseButton;
      
      private var _titlebg:Bitmap;
      
      public function OptionRightView()
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
         _pointBg = ComponentFactory.Instance.creatBitmap("asset.ddtlittleGame.pointbg");
         addChild(_pointBg);
         _pointInputBg = ComponentFactory.Instance.creatComponentByStylename("ddtlittleGameRightViewBG4");
         addChild(_pointInputBg);
         _pointTable = ComponentFactory.Instance.creatComponentByStylename("littleGame.MypointTxt");
         addChild(_pointTable);
         _pointTable.text = LanguageMgr.GetTranslation("ddtlittlegame.HaveAwardScore");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("littleGame.pointTxt");
         addChild(_pointTxt);
         _pointTxt.text = PlayerManager.Instance.Self.Score.toString();
         _btnGoback = ComponentFactory.Instance.creatComponentByStylename("littleGame.btnGobackHot");
         addChild(_btnGoback);
         _btnEnter = ComponentFactory.Instance.creatComponentByStylename("littleGame.btnEnterGame");
         addChild(_btnEnter);
         _listView = ComponentFactory.Instance.creatCustomObject("littleGame.awardList");
         addChild(_listView);
         _titlebg = ComponentFactory.Instance.creatBitmap("asset.ddtlittlegame.titlebg");
         addChild(_titlebg);
      }
      
      private function addEvent() : void
      {
         _btnGoback.addEventListener("click",__btnGobackClick);
         _btnEnter.addEventListener("click",__btnEnterClick);
         PlayerManager.Instance.Self.addEventListener("propertychange",onChange);
      }
      
      private function onChange(param1:PlayerPropertyEvent) : void
      {
         if(param1.changedProperties["Score"])
         {
            _pointTxt.text = PlayerManager.Instance.Self.Score.toString();
         }
      }
      
      private function __btnGobackClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         StateManager.setState("main");
      }
      
      private function __btnEnterClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.Grade >= PathManager.LittleGameMinLv)
         {
            _btnEnter.mouseEnabled = false;
            LittleGameManager.Instance.enterWorld();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("littlegame.MinLvNote",PathManager.LittleGameMinLv));
            ChatManager.Instance.sysChatYellow(LanguageMgr.GetTranslation("littlegame.MinLvNote",PathManager.LittleGameMinLv));
         }
      }
      
      private function removeEvent() : void
      {
         _btnGoback.removeEventListener("click",__btnGobackClick);
         _btnEnter.removeEventListener("click",__btnEnterClick);
         PlayerManager.Instance.Self.removeEventListener("propertychange",onChange);
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_rightViewBg)
         {
            ObjectUtils.disposeObject(_rightViewBg);
         }
         _rightViewBg = null;
         if(_rightViewBg1)
         {
            ObjectUtils.disposeObject(_rightViewBg1);
         }
         _rightViewBg1 = null;
         if(_rightViewBg2)
         {
            ObjectUtils.disposeObject(_rightViewBg2);
         }
         _rightViewBg2 = null;
         if(_pointInputBg)
         {
            ObjectUtils.disposeObject(_pointInputBg);
         }
         _pointInputBg = null;
         if(_pointTable)
         {
            ObjectUtils.disposeObject(_pointTable);
         }
         _pointTable = null;
         if(_titlebg)
         {
            ObjectUtils.disposeObject(_titlebg);
         }
         _titlebg = null;
         if(_pointBg)
         {
            ObjectUtils.disposeObject(_pointBg);
         }
         _pointBg = null;
         if(_pointTxt)
         {
            ObjectUtils.disposeObject(_pointTxt);
         }
         _pointTxt = null;
         if(_btnGoback)
         {
            ObjectUtils.disposeObject(_btnGoback);
         }
         _btnGoback = null;
         if(_btnEnter)
         {
            ObjectUtils.disposeObject(_btnEnter);
         }
         _btnEnter = null;
         if(_listView)
         {
            ObjectUtils.disposeObject(_listView);
         }
         _listView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
