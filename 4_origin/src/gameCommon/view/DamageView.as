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
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
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
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
            PositionUtils.setPos(_loc1_,"game.view.damageView.userNamePos" + _loc3_);
            _userNameVec.push(_loc1_);
            _infoSprite.addChild(_loc1_);
            _loc2_ = ComponentFactory.Instance.creatComponentByStylename("game.view.damageView.userInfo");
            PositionUtils.setPos(_loc2_,"game.view.damageView.damageNumPos" + _loc3_);
            _damageNumVec.push(_loc2_);
            _infoSprite.addChild(_loc2_);
            _loc3_++;
         }
         updateView();
      }
      
      private function initEvent() : void
      {
         _viewDamageBtn.addEventListener("click",__onMouseClick);
      }
      
      public function updateView() : void
      {
         var _loc1_:int = 0;
         clearTextInfo();
         var _loc4_:int = 0;
         var _loc3_:* = GameControl.Instance.Current.livings;
         for each(var _loc2_ in GameControl.Instance.Current.livings)
         {
            if(_loc2_.isPlayer())
            {
               _userNameVec[_loc1_].text = _loc2_.playerInfo.NickName;
               _damageNumVec[_loc1_].text = _loc2_.damageNum.toString();
               _loc2_.damageNum = 0;
               _loc1_++;
            }
         }
      }
      
      private function clearTextInfo() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _userNameVec.length)
         {
            _userNameVec[_loc1_].text = "";
            _damageNumVec[_loc1_].text = "";
            _loc1_++;
         }
      }
      
      protected function __onMouseClick(param1:MouseEvent) : void
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
         var _loc2_:int = 0;
         var _loc1_:int = 0;
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
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _userNameVec[_loc2_].dispose();
            _userNameVec[_loc2_] = null;
            _loc2_++;
         }
         _userNameVec.length = 0;
         _userNameVec = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _damageNumVec[_loc1_].dispose();
            _damageNumVec[_loc1_] = null;
            _loc1_++;
         }
         _damageNumVec.length = 0;
         _damageNumVec = null;
      }
   }
}
