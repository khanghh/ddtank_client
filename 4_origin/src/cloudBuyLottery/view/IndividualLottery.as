package cloudBuyLottery.view
{
   import bagAndInfo.cell.BaseCell;
   import cloudBuyLottery.CloudBuyLotteryManager;
   import com.greensock.TweenMax;
   import com.greensock.easing.Elastic;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   
   public class IndividualLottery extends Frame
   {
       
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Bitmap;
      
      private var _jubaoMC:MovieClip;
      
      private var _helpTxt:FilterFrameText;
      
      private var _juBaoBtn:BaseButton;
      
      private var _numTxt:FilterFrameText;
      
      private var _num:FilterFrameText;
      
      private var _selectSprite:Sprite;
      
      private var _selectedCell:BaseCell;
      
      private var itemInfo:ItemTemplateInfo;
      
      private var tInfo:InventoryItemInfo;
      
      private var flag:Boolean = false;
      
      private var gotoFlag:Boolean = true;
      
      private var _look:BaseButton;
      
      private var _lookGoods:LookGoodsFrame;
      
      private var _paopao:Bitmap;
      
      public function IndividualLottery()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.IndividualLottery.BG");
         _bg = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.BG");
         _jubaoMC = ClassUtils.CreatInstance("asset.IndividualLottery.jubaoMC") as MovieClip;
         PositionUtils.setPos(_jubaoMC,"IndividualLottery.jubaoMC");
         _helpTxt = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.helpTxt");
         _helpTxt.htmlText = LanguageMgr.GetTranslation("IndividualLottery.helpHtmlTxt",500);
         _juBaoBtn = ComponentFactory.Instance.creat("IndividualLottery.jubaoBtn");
         _num = ComponentFactory.Instance.creatComponentByStylename("IndividualLottery.num");
         _num.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
         _look = ComponentFactory.Instance.creat("IndividualLottery.lookGoodsBtn");
         _lookGoods = ComponentFactory.Instance.creatCustomObject("IndividualLottery.LookGoods");
         _paopao = ComponentFactory.Instance.creatBitmap("asset.cloudbuy.paopao");
         PositionUtils.setPos(_paopao,"asset.cloudbuy.paopao");
         addToContent(_bg2);
         addToContent(_bg);
         addToContent(_jubaoMC);
         addToContent(_helpTxt);
         addToContent(_juBaoBtn);
         addToContent(_paopao);
         addToContent(_num);
         addToContent(_look);
         var _loc2_:Point = ComponentFactory.Instance.creatCustomObject("IndividualLottery.selectCellSize");
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,_loc2_.x,_loc2_.y);
         _loc1_.graphics.endFill();
         _selectSprite = ComponentFactory.Instance.creatCustomObject("IndividualLottery.selectSprite");
         _selectedCell = new BaseCell(_loc1_);
         _selectedCell.x = _selectedCell.width / -2;
         _selectedCell.y = _selectedCell.height / -2;
         _selectedCell.visible = false;
         _selectSprite.addChild(_selectedCell);
         addToContent(_selectSprite);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         addEventListener("enterFrame",__onEnterFrame);
         _juBaoBtn.addEventListener("click",__onClick);
         _look.addEventListener("click",__lookGoods);
         CloudBuyLotteryManager.Instance.addEventListener("Individual",__updateInfo);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         removeEventListener("enterFrame",__onEnterFrame);
         CloudBuyLotteryManager.Instance.removeEventListener("Individual",__updateInfo);
      }
      
      private function __updateInfo(param1:Event) : void
      {
         if(CloudBuyLotteryManager.Instance.model.isGetReward)
         {
            _num.text = CloudBuyLotteryManager.Instance.model.remainTimes.toString();
            updateData(CloudBuyLotteryManager.Instance.model.luckDrawId);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IndividualLottery.getRewardTip"));
            addEventListener("response",__responseHandler);
            btnIsClick(true);
         }
      }
      
      private function updateData(param1:int) : void
      {
         itemInfo = ItemManager.Instance.getTemplateById(param1) as ItemTemplateInfo;
         tInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,itemInfo);
         flag = true;
      }
      
      private function __lookGoods(param1:MouseEvent) : void
      {
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc5_:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         var _loc3_:Array = CloudBuyLotteryManager.Instance.itemInfoList;
         if(_loc3_.length < 0)
         {
            return;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_.length)
         {
            _loc4_ = ItemManager.Instance.getTemplateById(_loc3_[_loc6_].TemplateID) as ItemTemplateInfo;
            _loc2_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc2_,_loc4_);
            _loc2_.ValidDate = _loc3_[_loc6_].ValidDate;
            _loc2_.StrengthenLevel = _loc3_[_loc6_].StrengthLevel;
            _loc2_.AttackCompose = _loc3_[_loc6_].AttackCompose;
            _loc2_.DefendCompose = _loc3_[_loc6_].DefendCompose;
            _loc2_.LuckCompose = _loc3_[_loc6_].LuckCompose;
            _loc2_.AgilityCompose = _loc3_[_loc6_].AgilityCompose;
            _loc2_.IsBinds = _loc3_[_loc6_].IsBind;
            _loc2_.Count = _loc3_[_loc6_].Count;
            _loc5_.push(_loc2_);
            _loc6_++;
         }
         _lookGoods.show(_loc5_);
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(int(_num.text) > 0)
         {
            btnIsClick(false);
            removeEventListener("response",__responseHandler);
            SocketManager.Instance.out.sendLuckDrawGo();
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IndividualLottery.NumNOTip"));
         }
      }
      
      private function __onEnterFrame(param1:Event) : void
      {
         if(flag)
         {
            if(gotoFlag)
            {
               gotoFlag = false;
               _jubaoMC.gotoAndPlay(41);
               _selectedCell.info = tInfo;
            }
            if(_jubaoMC.currentFrame >= 65)
            {
               flag = false;
               _selectedCell.visible = true;
               creatTweenMagnify();
            }
         }
      }
      
      private function btnIsClick(param1:Boolean) : void
      {
         if(param1)
         {
            _juBaoBtn.enable = true;
            _juBaoBtn.mouseChildren = true;
            _juBaoBtn.mouseEnabled = true;
         }
         else
         {
            _juBaoBtn.enable = false;
            _juBaoBtn.mouseChildren = false;
            _juBaoBtn.mouseEnabled = false;
         }
      }
      
      private function creatTweenMagnify(param1:Number = 1, param2:Number = 1.5, param3:int = -1, param4:Boolean = true, param5:int = 1100) : void
      {
         TweenMax.to(_selectSprite,param1,{
            "scaleX":param2,
            "scaleY":param2,
            "repeat":param3,
            "yoyo":param4,
            "ease":Elastic.easeOut
         });
      }
      
      private function _timeOut() : void
      {
         _clear();
      }
      
      private function _clear() : void
      {
         gotoFlag = true;
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("IndividualLottery.GoodsName",tInfo.Name));
         TweenMax.killTweensOf(_selectSprite);
         if(_selectedCell)
         {
            _selectedCell.visible = false;
         }
         if(_selectSprite)
         {
            var _loc1_:int = 1;
            _selectSprite.scaleY = _loc1_;
            _selectSprite.scaleX = _loc1_;
         }
      }
      
      private function showJuBaoBtn() : void
      {
         addEventListener("response",__responseHandler);
         btnIsClick(true);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1)
         {
            SoundManager.instance.play("008");
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(_lookGoods)
         {
            ObjectUtils.disposeObject(_lookGoods);
         }
         _lookGoods = null;
         super.dispose();
      }
   }
}
