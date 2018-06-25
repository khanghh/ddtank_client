package gameCommon.view
{
   import com.greensock.TweenLite;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   
   public class DamageView extends Sprite
   {
       
      
      private var _viewDamageBtn:BaseButton;
      
      private var _infoSprite:Sprite;
      
      private var _bg:Bitmap;
      
      private var _title:FilterFrameText;
      
      private var _listTxt:FilterFrameText;
      
      private var _userNameVec:Vector.<FilterFrameText>;
      
      private var _damageNumVec:Vector.<FilterFrameText>;
      
      private var _openFlag:Boolean = false;
      
      public function DamageView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var i:int = 0;
         var userName:* = null;
         var damageNum:* = null;
         _viewDamageBtn = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.viewDamageBtn");
         addChild(_viewDamageBtn);
         _infoSprite = new Sprite();
         addChild(_infoSprite);
         PositionUtils.setPos(_infoSprite,"asset.game.damageView.SpritePos");
         _bg = ComponentFactory.Instance.creat("asset.game.damageView.bg");
         _infoSprite.addChild(_bg);
         _title = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.titleTxt");
         _title.text = LanguageMgr.GetTranslation("ddt.game.view.damageView.titleText");
         _infoSprite.addChild(_title);
         _listTxt = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.listTxt");
         _listTxt.text = LanguageMgr.GetTranslation("ddt.game.view.damageView.listText");
         _infoSprite.addChild(_listTxt);
         _userNameVec = new Vector.<FilterFrameText>();
         _damageNumVec = new Vector.<FilterFrameText>();
         for(i = 0; i < 4; )
         {
            userName = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
            PositionUtils.setPos(userName,"game.view.damageView.userNamePos" + i);
            _userNameVec.push(userName);
            _infoSprite.addChild(userName);
            damageNum = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
            PositionUtils.setPos(damageNum,"game.view.damageView.damageNumPos" + i);
            _damageNumVec.push(damageNum);
            _infoSprite.addChild(damageNum);
            i++;
         }
         updateView();
      }
      
      private function initEvent() : void
      {
         _viewDamageBtn.addEventListener("click",__onMouseClick);
      }
      
      public function updateView() : void
      {
         var numID:int = 0;
         clearTextInfo();
         var _loc4_:int = 0;
         var _loc3_:* = GameControl.Instance.Current.livings;
         for each(var living in GameControl.Instance.Current.livings)
         {
            if(living.isPlayer())
            {
               _userNameVec[numID].text = living.playerInfo.NickName;
               _damageNumVec[numID].text = living.damageNum.toString();
               living.damageNum = 0;
               numID++;
            }
         }
      }
      
      private function clearTextInfo() : void
      {
         var i:int = 0;
         for(i = 0; i < _userNameVec.length; )
         {
            _userNameVec[i].text = "";
            _damageNumVec[i].text = "";
            i++;
         }
      }
      
      protected function __onMouseClick(event:MouseEvent) : void
      {
         if(_openFlag)
         {
            TweenLite.to(_infoSprite,0.3,{
               "x":0,
               "scaleX":1,
               "scaleY":1,
               "alpha":1
            });
         }
         else
         {
            TweenLite.to(_infoSprite,0.5,{
               "x":_viewDamageBtn.x + _viewDamageBtn.width / 2,
               "scaleX":0,
               "scaleY":0,
               "alpha":0
            });
         }
         _openFlag = !_openFlag;
      }
      
      private function removeEvent() : void
      {
         _viewDamageBtn.removeEventListener("click",__onMouseClick);
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var j:int = 0;
         removeEvent();
         if(_viewDamageBtn)
         {
            _viewDamageBtn.dispose();
            _viewDamageBtn = null;
         }
         if(_bg)
         {
            _bg.bitmapData.dispose();
            _bg = null;
         }
         if(_title)
         {
            _title.dispose();
            _title = null;
         }
         if(_listTxt)
         {
            _listTxt.dispose();
            _listTxt = null;
         }
         i = 0;
         while(i < 4)
         {
            _userNameVec[i].dispose();
            _userNameVec[i] = null;
            i++;
         }
         _userNameVec.length = 0;
         _userNameVec = null;
         for(j = 0; j < 4; )
         {
            _damageNumVec[j].dispose();
            _damageNumVec[j] = null;
            j++;
         }
         _damageNumVec.length = 0;
         _damageNumVec = null;
      }
   }
}
