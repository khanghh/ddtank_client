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
      
      public function WitchBlessingRightView(type:int, num:int = 0, money:int = 0)
      {
         _AwardsView = new Sprite();
         propertyArr1 = ["defense","agility","recovery","magicAttack"];
         propertyArr2 = ["attact","luck","damage","magicDefence"];
         property1 = [30,30,10,30];
         property2 = [30,30,15,30];
         blessingLV = type;
         allNum = num;
         doubleMoney = money;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var tempNum:int = 0;
         var txtArr:* = null;
         var i:int = 0;
         var txt:* = null;
         var ii:int = 0;
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
            txtArr = [];
            for(i = 1; i < 5; )
            {
               txt = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.propertyTxt");
               PositionUtils.setPos(txt,"witchBlessing.propertyTxtPos");
               txtArr.push(txt);
               txt.text = LanguageMgr.GetTranslation("tank.view.personalinfoII." + propertyArr1[i - 1]) + "+" + property1[i - 1];
               if(i != 1)
               {
                  txt.x = txt.x + tempNum;
               }
               tempNum = tempNum + (txt.width + 20);
               addChild(txt);
               i++;
            }
            if(blessingLV > 2)
            {
               _rightViewSmallBg = ComponentFactory.Instance.creat("asset.witchBlessing.rightViewSmallBg");
               addChild(_rightViewSmallBg);
               _awardsTxt2 = ComponentFactory.Instance.creatComponentByStylename("witchBlessing.awardsTxt");
               _awardsTxt2.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt3");
               addChild(_awardsTxt2);
               PositionUtils.setPos(_awardsTxt2,"witchBlessing.AwardsTxt3Pos");
               tempNum = 0;
               for(ii = 1; ii < 5; )
               {
                  txtArr[ii - 1].text = LanguageMgr.GetTranslation("tank.view.personalinfoII." + propertyArr2[ii - 1]) + "+" + property2[ii - 1];
                  PositionUtils.setPos(txtArr[ii - 1],"witchBlessing.propertyTxtPos");
                  if(i != 1)
                  {
                     txtArr[ii - 1].x = txtArr[ii - 1].x + tempNum;
                  }
                  tempNum = tempNum + (txtArr[ii - 1].width + 20);
                  ii++;
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
      
      private function getAwardsFunc(ee:MouseEvent) : void
      {
         SocketManager.Instance.out.sendWitchGetAwards(blessingLV);
      }
      
      private function getDoubleAwardsFunc(ee:MouseEvent) : void
      {
         var alert:* = null;
         var alert1:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.Money < doubleMoney)
         {
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("witchBlessing.view.haveNoMoney"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert.addEventListener("response",__onNoMoneyResponse);
         }
         else
         {
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("witchBlessing.view.doubleGetAwardsMoney",doubleMoney),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,false,false,1);
            alert1.addEventListener("response",__getDoubleAwards);
         }
      }
      
      private function __getDoubleAwards(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onNoMoneyResponse);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
         {
            SocketManager.Instance.out.sendWitchGetAwards(blessingLV,true);
         }
      }
      
      private function __onNoMoneyResponse(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = e.currentTarget as BaseAlerFrame;
         alert.removeEventListener("response",__onNoMoneyResponse);
         alert.disposeChildren = true;
         alert.dispose();
         alert = null;
         if(e.responseCode == 3)
         {
            LeavePageManager.leaveToFillPath();
         }
      }
      
      private function __timer(e:TimerEvent) : void
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
      
      public function cannotBlessing(val:Boolean) : void
      {
         _noBlessing.visible = !val;
      }
      
      private function isCanGetAwards(val:Boolean) : void
      {
         if(canGetAwardsFlag == val)
         {
            return;
         }
         if(val)
         {
            _getAwardsBtn.enable = true;
            _getDoubleAwardsBtn.enable = true;
         }
         else
         {
            _getAwardsBtn.enable = false;
            _getDoubleAwardsBtn.enable = false;
         }
         canGetAwardsFlag = val;
      }
      
      private function transSecond(num:Number) : String
      {
         var hour:int = Math.floor(num / 3600);
         var min:int = Math.floor((num - hour * 3600) / 60);
         var sec:int = num - hour * 3600 - min * 60;
         if(hour > 0)
         {
            str = hour + "" + LanguageMgr.GetTranslation("hour") + min + LanguageMgr.GetTranslation("minute");
         }
         else if(min > 0)
         {
            str = min + "" + LanguageMgr.GetTranslation("minute") + sec + "" + LanguageMgr.GetTranslation("second");
         }
         else
         {
            str = sec + "" + LanguageMgr.GetTranslation("second");
         }
         return str;
      }
      
      public function flushCDTime(sec:int) : void
      {
         cdTime = sec;
         if(cdTime > 0 && !_timer.running)
         {
            _timer.start();
         }
         timeCountingFunc();
      }
      
      public function flushGetAwardsTimes(num:int) : void
      {
         awardsNum = allNum - num;
         _awardsTxt1.text = LanguageMgr.GetTranslation("witchBlessing.view.awardsTxt1",allNum,awardsNum);
      }
      
      private function initAwards() : void
      {
         var i:int = 0;
         var info:* = null;
         var itemInfo:* = null;
         var bg:* = null;
         var cell:* = null;
         var awardsArr:Array = WitchBlessingManager.Instance.model.itemInfoList;
         var tempNum:int = 340 / (awardsArr[blessingLV - 1].length - 1);
         for(i = 0; i < awardsArr[blessingLV - 1].length; )
         {
            info = awardsArr[blessingLV - 1][i] as WitchBlessingPackageInfo;
            itemInfo = ItemManager.Instance.getTemplateById(info.TemplateID) as ItemTemplateInfo;
            bg = ComponentFactory.Instance.creatBitmap("asset.witchBlessing.sugerBox");
            cell = new BagCell(i,itemInfo,false,bg,false);
            cell.setContentSize(62,62);
            cell.PicPos = new Point(3,3);
            cell.setCount(info.Count);
            cell.x = i * tempNum;
            _AwardsView.addChild(cell);
            i++;
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
