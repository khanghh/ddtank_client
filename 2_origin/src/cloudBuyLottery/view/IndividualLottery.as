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
         var size:Point = ComponentFactory.Instance.creatCustomObject("IndividualLottery.selectCellSize");
         var shape:Shape = new Shape();
         shape.graphics.beginFill(16777215,0);
         shape.graphics.drawRect(0,0,size.x,size.y);
         shape.graphics.endFill();
         _selectSprite = ComponentFactory.Instance.creatCustomObject("IndividualLottery.selectSprite");
         _selectedCell = new BaseCell(shape);
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
      
      private function __updateInfo(e:Event) : void
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
      
      private function updateData(id:int) : void
      {
         itemInfo = ItemManager.Instance.getTemplateById(id) as ItemTemplateInfo;
         tInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,itemInfo);
         flag = true;
      }
      
      private function __lookGoods(evt:MouseEvent) : void
      {
         var i:int = 0;
         var itemInfo:* = null;
         var tInfo:* = null;
         var list:Vector.<InventoryItemInfo> = new Vector.<InventoryItemInfo>();
         var goods:Array = CloudBuyLotteryManager.Instance.itemInfoList;
         if(goods.length < 0)
         {
            return;
         }
         i = 0;
         while(i < goods.length)
         {
            itemInfo = ItemManager.Instance.getTemplateById(goods[i].TemplateID) as ItemTemplateInfo;
            tInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(tInfo,itemInfo);
            tInfo.ValidDate = goods[i].ValidDate;
            tInfo.StrengthenLevel = goods[i].StrengthLevel;
            tInfo.AttackCompose = goods[i].AttackCompose;
            tInfo.DefendCompose = goods[i].DefendCompose;
            tInfo.LuckCompose = goods[i].LuckCompose;
            tInfo.AgilityCompose = goods[i].AgilityCompose;
            tInfo.IsBinds = goods[i].IsBind;
            tInfo.Count = goods[i].Count;
            list.push(tInfo);
            i++;
         }
         _lookGoods.show(list);
      }
      
      private function __onClick(evt:MouseEvent) : void
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
      
      private function __onEnterFrame(evt:Event) : void
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
      
      private function btnIsClick(flag:Boolean) : void
      {
         if(flag)
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
      
      private function creatTweenMagnify(duration:Number = 1, scale:Number = 1.5, repeat:int = -1, yoyo:Boolean = true, delay:int = 1100) : void
      {
         TweenMax.to(_selectSprite,duration,{
            "scaleX":scale,
            "scaleY":scale,
            "repeat":repeat,
            "yoyo":yoyo,
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
      
      private function __responseHandler(evt:FrameEvent) : void
      {
         if(evt.responseCode == 0 || evt.responseCode == 1)
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
