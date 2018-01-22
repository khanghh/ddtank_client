package ddt.view.academyCommon.myAcademy.myAcademyItem
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.command.QuickBuyFrame;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.IMManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.PlayerTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import ddt.view.common.LevelIcon;
   import ddt.view.common.SexIcon;
   import email.MailManager;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import im.IMEvent;
   import vip.VipController;
   
   public class MyAcademyMasterItem extends Sprite implements Disposeable
   {
       
      
      protected var _nameTxt:FilterFrameText;
      
      protected var _vipName:GradientText;
      
      protected var _offLineText:FilterFrameText;
      
      protected var _removeBtn:TextButton;
      
      protected var _itemBG:ScaleFrameImage;
      
      protected var _line11:ScaleBitmapImage;
      
      protected var _line22:ScaleBitmapImage;
      
      protected var _line33:ScaleBitmapImage;
      
      protected var _line44:ScaleBitmapImage;
      
      protected var _levelIcon:LevelIcon;
      
      protected var _sexIcon:SexIcon;
      
      protected var _info:PlayerInfo;
      
      protected var _isSelect:Boolean;
      
      protected var _addFriend:TextButton;
      
      protected var _emailBtn:TextButton;
      
      protected var _removeGold:int;
      
      public function MyAcademyMasterItem()
      {
         super();
         init();
         initEvent();
         initComponent();
      }
      
      public function set info(param1:PlayerInfo) : void
      {
         _info = param1;
         updateComponent();
      }
      
      public function get info() : PlayerInfo
      {
         return _info;
      }
      
      protected function init() : void
      {
         _itemBG = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.itemBG");
         _itemBG.setFrame(1);
         addChild(_itemBG);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.nameTxt");
         _offLineText = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.offLineText");
         addChild(_offLineText);
         _levelIcon = ComponentFactory.Instance.creatCustomObject("academyCommon.myAcademy.MyAcademyMasterItem.levelIcon");
         _levelIcon.setSize(1);
         addChild(_levelIcon);
         _sexIcon = new SexIcon();
         _sexIcon.visible = false;
         addChild(_sexIcon);
         _removeBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.removeBtn");
         _removeBtn.text = LanguageMgr.GetTranslation("ddt.view.academyCommon.itemtitle.removeBtnText");
         addChild(_removeBtn);
         _addFriend = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.addFriendBtn");
         _addFriend.text = LanguageMgr.GetTranslation("civil.leftview.addName");
         _addFriend.visible = false;
         addChild(_addFriend);
         _emailBtn = ComponentFactory.Instance.creatComponentByStylename("academyCommon.myAcademy.MyAcademyMasterItem.emailBtn");
         _emailBtn.text = LanguageMgr.GetTranslation("itemview.emailText");
         addChild(_emailBtn);
         _line11 = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyItem.formIine11");
         addChild(_line11);
         _line22 = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyItem.formIine22");
         addChild(_line22);
         _line33 = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyItem.formIine33");
         addChild(_line33);
         _line44 = ComponentFactory.Instance.creatComponentByStylename("academyCommon.MyAcademyItem.formIine44");
         addChild(_line44);
      }
      
      protected function initEvent() : void
      {
         _itemBG.addEventListener("click",__onMouseClick);
         _removeBtn.addEventListener("click",__removeClick);
         _addFriend.addEventListener("click",__addFriendClick);
         _emailBtn.addEventListener("click",__emailBtnClick);
         PlayerManager.Instance.addEventListener("addnewfriend",__addFriend);
      }
      
      private function __addFriend(param1:IMEvent) : void
      {
         if(_info && (param1.data as PlayerInfo).ID == _info.ID)
         {
            _addFriend.enable = false;
         }
      }
      
      private function __emailBtnClick(param1:MouseEvent) : void
      {
         MailManager.Instance.showWriting(_info.NickName);
      }
      
      private function __addFriendClick(param1:MouseEvent) : void
      {
         IMManager.Instance.addFriend(_info.NickName);
      }
      
      protected function __removeClick(param1:MouseEvent) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         SoundManager.instance.play("008");
         var _loc4_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("AlertDialog.Info"));
         if(!getTimerOvertop())
         {
            _loc4_.data = LanguageMgr.GetTranslation("ddt.view.academyCommon.myAcademy.MyAcademyApprenticeItem.remove",_info.NickName);
            _loc3_ = AlertManager.Instance.alert("academySimpleAlert",_loc4_,2);
            _loc3_.addEventListener("response",__frameEvent);
         }
         else
         {
            _loc4_.data = LanguageMgr.GetTranslation("ddt.view.academyCommon.myAcademy.MyAcademyApprenticeItem.removeII",_info.NickName);
            _loc2_ = AlertManager.Instance.alert("academySimpleAlert",_loc4_,2);
            _loc2_.addEventListener("response",__alerFrameEvent);
         }
      }
      
      protected function __alerFrameEvent(param1:FrameEvent) : void
      {
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (param1.currentTarget as BaseAlerFrame).dispose();
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               submit();
         }
      }
      
      protected function __frameEvent(param1:FrameEvent) : void
      {
         var _loc2_:* = null;
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",__frameEvent);
         (param1.currentTarget as BaseAlerFrame).dispose();
         SoundManager.instance.play("008");
         switch(int(param1.responseCode) - 2)
         {
            case 0:
            case 1:
               if(PlayerManager.Instance.Self.Gold >= 10000)
               {
                  submit();
                  break;
               }
               _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.view.GoldInadequate"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
               _loc2_.moveEnable = false;
               _loc2_.addEventListener("response",__quickBuyResponse);
               break;
         }
      }
      
      protected function __quickBuyResponse(param1:FrameEvent) : void
      {
         var _loc3_:* = null;
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__quickBuyResponse);
         _loc2_.dispose();
         if(_loc2_.parent)
         {
            _loc2_.parent.removeChild(_loc2_);
         }
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtcore.QuickFrame");
            _loc3_.itemID = 11233;
            _loc3_.setTitleText(LanguageMgr.GetTranslation("tank.view.store.matte.goldQuickBuy"));
            LayerManager.Instance.addToLayer(_loc3_,2,true,1);
         }
      }
      
      protected function submit() : void
      {
         SocketManager.Instance.out.sendAcademyFireMaster(_info.ID);
      }
      
      private function __onMouseClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         PlayerTipManager.show(_info,_itemBG.localToGlobal(new Point(0,0)).y);
      }
      
      protected function initComponent() : void
      {
         _removeGold = 10000;
         _sexIcon.visible = false;
      }
      
      protected function updateComponent() : void
      {
         _nameTxt.text = _info.NickName;
         if(_nameTxt.text.length > 7)
         {
            _nameTxt.text = _nameTxt.text.substr(0,6) + "...";
         }
         if(_info.IsVIP)
         {
            ObjectUtils.disposeObject(_vipName);
            _vipName = VipController.instance.getVipNameTxt(141,_info.typeVIP);
            _vipName.x = _nameTxt.x;
            _vipName.y = _nameTxt.y;
            _vipName.text = _nameTxt.text;
            addChild(_vipName);
            addChild(_nameTxt);
            PositionUtils.adaptNameStyle(_info,_nameTxt,_vipName);
         }
         else
         {
            addChild(_nameTxt);
            DisplayUtils.removeDisplay(_vipName);
         }
         if(_info.playerState.StateID != 0)
         {
            _offLineText.text = LanguageMgr.GetTranslation("tank.view.im.IMFriendList.online");
         }
         else
         {
            _offLineText.text = _info.getLastDate().toString() + LanguageMgr.GetTranslation("hours");
         }
         _levelIcon.setInfo(_info.Grade,_info.ddtKingGrade,_info.Repute,_info.WinCount,_info.TotalCount,_info.FightPower,_info.Offer,true,false);
         _sexIcon.setSex(_info.Sex);
         if(IMManager.Instance.isFriend(_info.NickName))
         {
            _addFriend.enable = false;
         }
         else
         {
            _addFriend.enable = true;
         }
      }
      
      protected function getTimerOvertop() : Boolean
      {
         if(_info.playerState.StateID != 0)
         {
            return false;
         }
         var _loc3_:Date = TimeManager.Instance.Now();
         var _loc2_:Date = _info.lastDate;
         var _loc1_:Number = (_loc3_.valueOf() - _loc2_.valueOf()) / 3600000;
         return _loc1_ > 72?true:false;
      }
      
      public function set isSelect(param1:Boolean) : void
      {
      }
      
      public function get isSelect() : Boolean
      {
         return _isSelect;
      }
      
      public function dispose() : void
      {
         if(_itemBG)
         {
            _itemBG.removeEventListener("click",__onMouseClick);
         }
         if(_removeBtn)
         {
            _removeBtn.removeEventListener("click",__removeClick);
         }
         if(_addFriend)
         {
            _addFriend.removeEventListener("click",__addFriendClick);
         }
         if(_emailBtn)
         {
            _emailBtn.removeEventListener("click",__emailBtnClick);
         }
         PlayerManager.Instance.removeEventListener("addnewfriend",__addFriend);
         if(_nameTxt)
         {
            ObjectUtils.disposeObject(_nameTxt);
            _nameTxt = null;
         }
         if(_offLineText)
         {
            ObjectUtils.disposeObject(_offLineText);
            _offLineText = null;
         }
         if(_removeBtn)
         {
            ObjectUtils.disposeObject(_removeBtn);
            _removeBtn = null;
         }
         if(_itemBG)
         {
            ObjectUtils.disposeObject(_itemBG);
            _itemBG = null;
         }
         if(_line11)
         {
            ObjectUtils.disposeObject(_line11);
            _line11 = null;
         }
         if(_line22)
         {
            ObjectUtils.disposeObject(_line22);
            _line22 = null;
         }
         if(_line33)
         {
            ObjectUtils.disposeObject(_line33);
            _line33 = null;
         }
         if(_line44)
         {
            ObjectUtils.disposeObject(_line44);
            _line44 = null;
         }
         if(_levelIcon)
         {
            ObjectUtils.disposeObject(_levelIcon);
            _levelIcon = null;
         }
         if(_sexIcon)
         {
            ObjectUtils.disposeObject(_sexIcon);
            _sexIcon = null;
         }
         if(_addFriend)
         {
            ObjectUtils.disposeObject(_addFriend);
            _addFriend = null;
         }
         if(_emailBtn)
         {
            ObjectUtils.disposeObject(_emailBtn);
            _emailBtn = null;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
