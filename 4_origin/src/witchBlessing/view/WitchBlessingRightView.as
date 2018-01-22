package witchBlessing.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import witchBlessing.WitchBlessingController;
   import witchBlessing.WitchBlessingManager;
   import witchBlessing.data.WitchBlessingPackageInfo;
   
   public class WitchBlessingRightView extends Sprite implements Disposeable
   {
       
      
      private var blessingLV:int = 1;
      
      private var _rightViewMidBg:Bitmap;
      
      private var _rightViewSmallBg:Bitmap;
      
      private var _noBlessing:Bitmap;
      
      private var _AwardsView:Sprite;
      
      private var _awardsTxt:FilterFrameText;
      
      private var _awardsTxt1:FilterFrameText;
      
      private var _awardsTxt2:FilterFrameText;
      
      private var _nextTimeTxt:FilterFrameText;
      
      private var propertyArr1:Array;
      
      private var propertyArr2:Array;
      
      private var property1:Array;
      
      private var property2:Array;
      
      private var _getAwardsBtn:BaseButton;
      
      private var _getDoubleAwardsBtn:BaseButton;
      
      private var cdTime:int = 0;
      
      private var _timer:Timer;
      
      private var canGetAwardsFlag:Boolean = false;
      
      private var awardsNum:int;
      
      private var allNum:int;
      
      private var doubleMoney:int = 0;
      
      private var sec:int;
      
      private var min:int;
      
      private var hour:int;
      
      private var str:String;
      
      public function WitchBlessingRightView(param1:int, param2:int = 0, param3:int = 0)
      {
         _AwardsView = new Sprite();
         propertyArr1 = ["defense","agility","recovery","magicAttack"];
         propertyArr2 = ["attact","luck","damage","magicDefence"];
         property1 = [30,30,10,30];
         property2 = [30,30,15,30];
         blessingLV = param1;
         allNum = param2;
         doubleMoney = param3;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = 0;
         addChild(_AwardsView);
         PositionUtils.setPos(_AwardsView,"witchBlessing.AwardsViewPos");
         _getAwardsBtn = ComponentFactory.Instance.creat("witchBlessing.getAwardsBtn");
         _getAwardsBtn.enable = false;
         _getDoubleAwardsBtn = ComponentFactory.Instance.creat("witchBlessing.getDoubleAwardsBtn");
         _getDoubleAwardsBtn.enable = false;
         _noBlessing = ComponentFactory.Instance.creat("asset.witchBlessing.noBlessing");
         addChild(_noBlessing);
         addChild(_getAwardsBtn);
         addChild(_getDoubleAwardsBtn);
         _nextTimeTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.nextTimeTxt");
         _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.nextTimeTxt");
         addChild(_nextTimeTxt);
         _awardsTxt1 = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.awardsTxt");
         _awardsTxt1.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt1",3,3);
         addChild(_awardsTxt1);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timer);
         if(blessingLV > 1)
         {
            _rightViewMidBg = ComponentFactory.Instance.creat("asset.witchBlessing.rightViewMidBg");
            addChild(_rightViewMidBg);
            _awardsTxt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.awardsTxt");
            _awardsTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt2");
            addChild(_awardsTxt);
            PositionUtils.setPos(_awardsTxt,"witchBlessing.AwardsTxt2Pos");
            _loc1_ = [];
            _loc5_ = 1;
            while(_loc5_ < 5)
            {
               _loc4_ = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.propertyTxt");
               PositionUtils.setPos(_loc4_,"witchBlessing.propertyTxtPos");
               _loc1_.push(_loc4_);
               _loc4_.text = LanguageMgr.GetTranslation("tank.view.personalinfoII." + propertyArr1[_loc5_ - 1]) + "+" + property1[_loc5_ - 1];
               if(_loc5_ != 1)
               {
                  _loc4_.x = _loc4_.x + _loc2_;
               }
               _loc2_ = _loc2_ + (_loc4_.width + 20);
               addChild(_loc4_);
               _loc5_++;
            }
            if(blessingLV > 2)
            {
               _rightViewSmallBg = ComponentFactory.Instance.creat("asset.witchBlessing.rightViewSmallBg");
               addChild(_rightViewSmallBg);
               _awardsTxt2 = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.awardsTxt");
               _awardsTxt2.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt3");
               addChild(_awardsTxt2);
               PositionUtils.setPos(_awardsTxt2,"witchBlessing.AwardsTxt3Pos");
               _loc2_ = 0;
               _loc3_ = 1;
               while(_loc3_ < 5)
               {
                  _loc1_[_loc3_ - 1].text = LanguageMgr.GetTranslation("tank.view.personalinfoII." + propertyArr2[_loc3_ - 1]) + "+" + property2[_loc3_ - 1];
                  PositionUtils.setPos(_loc1_[_loc3_ - 1],"witchBlessing.propertyTxtPos");
                  if(_loc5_ != 1)
                  {
                     _loc1_[_loc3_ - 1].x = _loc1_[_loc3_ - 1].x + _loc2_;
                  }
                  _loc2_ = _loc2_ + (_loc1_[_loc3_ - 1].width + 20);
                  _loc3_++;
               }
            }
         }
         initAwards();
      }
      
      private function initEvent() : void
      {
         _getAwardsBtn.addEventListener("click",getAwardsFunc);
         _getDoubleAwardsBtn.addEventListener("click",getDoubleAwardsFunc);
      }
      
      private function getAwardsFunc(param1:MouseEvent) : void
      {
         SocketManager.Instance.out.sendWitchGetAwards(blessingLV);
      }
      
      private function getDoubleAwardsFunc(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < doubleMoney)
         {
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("witchBlessing.view.haveNoMoney"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc2_.addEventListener("response",__onNoMoneyResponse);
         }
         else
         {
            _loc3_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("witchBlessing.view.doubleGetAwardsMoney",doubleMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            _loc3_.addEventListener("response",__getDoubleAwards);
         }
      }
      
      private function __getDoubleAwards(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onNoMoneyResponse);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            SocketManager.Instance.out.sendWitchGetAwards(blessingLV,true);
         }
      }
      
      private function __onNoMoneyResponse(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:BaseAlerFrame = param1.currentTarget as BaseAlerFrame;
         _loc2_.removeEventListener("response",__onNoMoneyResponse);
         _loc2_.disposeChildren = true;
         _loc2_.dispose();
         _loc2_ = null;
         if(param1.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __timer(param1:TimerEvent) : void
      {
         timeCountingFunc();
         cdTime = cdTime - 1000;
      }
      
      private function timeCountingFunc() : void
      {
         if(cdTime <= 0)
         {
            _timer.stop();
            if(awardsNum > 0 && blessingLV <= WitchBlessingController.Instance.frame.nowLv)
            {
               _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.canGetAwardsTxt");
               isCanGetAwards(true);
               cannotBlessing(true);
            }
            else
            {
               if(blessingLV > WitchBlessingController.Instance.frame.nowLv)
               {
                  _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.notEnoughLv");
                  cannotBlessing(false);
               }
               else
               {
                  _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.noAwardsTxt");
                  cannotBlessing(true);
               }
               isCanGetAwards(false);
            }
         }
         else
         {
            if(awardsNum == 0)
            {
               _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.noAwardsTxt");
               if(blessingLV > WitchBlessingController.Instance.frame.nowLv)
               {
                  cannotBlessing(false);
               }
               else
               {
                  cannotBlessing(true);
               }
            }
            else if(blessingLV > WitchBlessingController.Instance.frame.nowLv)
            {
               _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.notEnoughLv");
               cannotBlessing(false);
            }
            else
            {
               sec = int(cdTime / 1000);
               _nextTimeTxt.text = LanguageMgr.GetTranslation("witchBlessing.view.nextTimeTxt",transSecond(sec));
               cannotBlessing(true);
            }
            isCanGetAwards(false);
         }
      }
      
      public function cannotBlessing(param1:Boolean) : void
      {
         _noBlessing.visible = !param1;
      }
      
      private function isCanGetAwards(param1:Boolean) : void
      {
         if(canGetAwardsFlag == param1)
         {
            return;
         }
         if(param1)
         {
            _getAwardsBtn.enable = true;
            _getDoubleAwardsBtn.enable = true;
         }
         else
         {
            _getAwardsBtn.enable = false;
            _getDoubleAwardsBtn.enable = false;
         }
         canGetAwardsFlag = param1;
      }
      
      private function transSecond(param1:Number) : String
      {
         var _loc4_:int = Math.floor(param1 / 3600);
         var _loc2_:int = Math.floor((param1 - _loc4_ * 3600) / 60);
         var _loc3_:int = param1 - _loc4_ * 3600 - _loc2_ * 60;
         if(_loc4_ > 0)
         {
            str = _loc4_ + "" + LanguageMgr.GetTranslation("hour") + _loc2_ + LanguageMgr.GetTranslation("minute");
         }
         else if(_loc2_ > 0)
         {
            str = _loc2_ + "" + LanguageMgr.GetTranslation("minute") + _loc3_ + "" + LanguageMgr.GetTranslation("second");
         }
         else
         {
            str = _loc3_ + "" + LanguageMgr.GetTranslation("second");
         }
         return str;
      }
      
      public function flushCDTime(param1:int) : void
      {
         cdTime = param1;
         if(cdTime > 0 && !_timer.running)
         {
            _timer.start();
         }
         timeCountingFunc();
      }
      
      public function flushGetAwardsTimes(param1:int) : void
      {
         awardsNum = allNum - param1;
         _awardsTxt1.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt1",allNum,awardsNum);
      }
      
      private function initAwards() : void
      {
         var _loc7_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:Array = WitchBlessingManager.Instance.model.itemInfoList;
         var _loc1_:int = 340 / (_loc5_[blessingLV - 1].length - 1);
         _loc7_ = 0;
         while(_loc7_ < _loc5_[blessingLV - 1].length)
         {
            _loc6_ = _loc5_[blessingLV - 1][_loc7_] as WitchBlessingPackageInfo;
            _loc4_ = ItemManager.Instance.getTemplateById(_loc6_.TemplateID) as ItemTemplateInfo;
            _loc3_ = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.sugerBox");
            _loc2_ = new BagCell(_loc7_,_loc4_,false,_loc3_,false);
            _loc2_.setContentSize(62,62);
            _loc2_.PicPos = new Point(3,3);
            _loc2_.setCount(_loc6_.Count);
            _loc2_.x = _loc7_ * _loc1_;
            _AwardsView.addChild(_loc2_);
            _loc7_++;
         }
      }
      
      public function dispose() : void
      {
         _timer.stop();
         _timer = null;
         ObjectUtils.disposeAllChildren(this);
         if(_rightViewMidBg)
         {
            _rightViewMidBg = null;
         }
         if(_rightViewSmallBg)
         {
            _rightViewSmallBg = null;
         }
         if(_noBlessing)
         {
            _noBlessing = null;
         }
         if(_AwardsView)
         {
            _AwardsView = null;
         }
         if(_awardsTxt)
         {
            _awardsTxt = null;
         }
         if(_awardsTxt1)
         {
            _awardsTxt1 = null;
         }
         if(_awardsTxt2)
         {
            _awardsTxt2 = null;
         }
         if(_nextTimeTxt)
         {
            _nextTimeTxt = null;
         }
      }
   }
}
