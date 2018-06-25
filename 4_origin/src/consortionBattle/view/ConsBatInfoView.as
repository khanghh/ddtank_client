package consortionBattle.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.ConsortiaBattleManager;
   import ddt.manager.PlayerManager;
   import ddt.utils.PositionUtils;
   import ddt.view.PlayerPortraitView;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ConsBatInfoView extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _hp:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _hpTxt:FilterFrameText;
      
      private var _victoryCountTxt:FilterFrameText;
      
      private var _winningStreakTxt:FilterFrameText;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _portrait:PlayerPortraitView;
      
      private var _hpWidth:Number;
      
      public function ConsBatInfoView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.infoView.bg");
         _hp = ComponentFactory.Instance.creatBitmap("asset.consortiaBattle.infoView.hp");
         _hpWidth = _hp.width;
         _portrait = new PlayerPortraitView("right");
         PositionUtils.setPos(_portrait,"consortiaBattle.portraitPos");
         _portrait.info = PlayerManager.Instance.Self;
         _portrait.isShowFrame = false;
         var maskSprite:Sprite = new Sprite();
         maskSprite.graphics.beginFill(16711680,0.5);
         maskSprite.graphics.drawCircle(0,0,35);
         maskSprite.graphics.endFill();
         PositionUtils.setPos(maskSprite,"consortiaBattle.portraitMaskPos");
         _portrait.mask = maskSprite;
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.infoView.nameTxt");
         _nameTxt.text = PlayerManager.Instance.Self.NickName;
         _hpTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.infoView.hpTxt");
         _victoryCountTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.infoView.infoTxt");
         _winningStreakTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.infoView.infoTxt");
         _winningStreakTxt.textFormatStyle = "consortiaBattle.infoView.infoTxt2.tf";
         PositionUtils.setPos(_winningStreakTxt,"consortiaBattle.winningStreakTxtPos");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("consortiaBattle.infoView.infoTxt");
         PositionUtils.setPos(_scoreTxt,"consortiaBattle.socreTxtPos");
         addChild(_bg);
         addChild(_portrait);
         addChild(maskSprite);
         addChild(_hp);
         addChild(_nameTxt);
         addChild(_hpTxt);
         addChild(_victoryCountTxt);
         addChild(_winningStreakTxt);
         addChild(_scoreTxt);
      }
      
      private function initEvent() : void
      {
         ConsortiaBattleManager.instance.addEventListener("consortiaBattleUpdateSceneInfo",refreshView);
      }
      
      private function refreshView(event:Event = null) : void
      {
         var totalHp:int = PlayerManager.Instance.Self.hp;
         var tmp:int = ConsortiaBattleManager.instance.curHp == -1?totalHp:int(ConsortiaBattleManager.instance.curHp);
         _hpTxt.text = tmp + "/" + totalHp;
         _hp.width = tmp / totalHp * _hpWidth;
         _victoryCountTxt.text = ConsortiaBattleManager.instance.victoryCount.toString();
         _winningStreakTxt.text = ConsortiaBattleManager.instance.winningStreak.toString();
         _scoreTxt.text = ConsortiaBattleManager.instance.score.toString();
      }
      
      private function removeEvent() : void
      {
         ConsortiaBattleManager.instance.removeEventListener("consortiaBattleUpdateSceneInfo",refreshView);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         _hp = null;
         _portrait = null;
         _nameTxt = null;
         _hpTxt = null;
         _victoryCountTxt = null;
         _winningStreakTxt = null;
         _scoreTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
