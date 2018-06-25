package totem.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import dragonBoat.DragonBoatManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import totem.TotemManager;
   import totem.data.TotemDataVo;
   import totem.mornUI.TotemLeftWindowActiveViewUI;
   import trainer.view.NewHandContainer;
   
   public class TotemLeftWindowActiveView extends TotemLeftWindowActiveViewUI
   {
       
      
      private var _totemPointBgList:Vector.<BitmapData>;
      
      private var _totemPointIconList:Vector.<BitmapData>;
      
      private var _totemPointSprite:Sprite;
      
      private var _totemPointList:Vector.<TotemLeftWindowTotemCell>;
      
      private var _curCanClickPointLocation:int;
      
      private var _totemPointLocationList:Array;
      
      private var _windowBorder:Bitmap;
      
      private var _lineShape:Shape;
      
      private var _lightGlowFilter:GlowFilter;
      
      private var _grayGlowFilter:ColorMatrixFilter;
      
      private var _openCartoonSprite:TotemLeftWindowOpenCartoonView;
      
      private var _propertyTxtSprite:TotemLeftWindowPropertyTxtView;
      
      private var _tipView:TotemPointTipView;
      
      private var _selectBtn:SelectedCheckButton;
      
      private var confirmFrame:BaseAlerFrame;
      
      public function TotemLeftWindowActiveView()
      {
         _totemPointLocationList = [[{
            "x":300,
            "y":300
         },{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":200,
            "y":200
         },{
            "x":300,
            "y":100
         },{
            "x":450,
            "y":150
         },{
            "x":450,
            "y":300
         }],[{
            "x":100,
            "y":100
         },{
            "x":100,
            "y":300
         },{
            "x":200,
            "y":200
         },{
            "x":300,
            "y":300
         },{
            "x":450,
            "y":300
         },{
            "x":450,
            "y":150
         },{
            "x":300,
            "y":100
         }],[{
            "x":100,
            "y":200
         },{
            "x":150,
            "y":100
         },{
            "x":250,
            "y":200
         },{
            "x":150,
            "y":300
         },{
            "x":350,
            "y":300
         },{
            "x":450,
            "y":200
         },{
            "x":350,
            "y":100
         }],[{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":250,
            "y":150
         },{
            "x":250,
            "y":300
         },{
            "x":400,
            "y":300
         },{
            "x":450,
            "y":200
         },{
            "x":350,
            "y":100
         }],[{
            "x":300,
            "y":300
         },{
            "x":200,
            "y":200
         },{
            "x":100,
            "y":300
         },{
            "x":100,
            "y":100
         },{
            "x":300,
            "y":100
         },{
            "x":450,
            "y":300
         },{
            "x":450,
            "y":150
         }]];
         super();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         super.initialize();
         _totemPointBgList = new Vector.<BitmapData>();
         for(i = 1; i <= 5; )
         {
            _totemPointBgList.push(ComponentFactory.Instance.creatBitmapData("asset.totem.totemPointBg" + i));
            i++;
         }
         _totemPointIconList = new Vector.<BitmapData>();
         for(i = 1; i <= 7; )
         {
            _totemPointIconList.push(ComponentFactory.Instance.creatBitmapData("asset.totem.totemPointIcon" + i));
            i++;
         }
         _openCartoonSprite = new TotemLeftWindowOpenCartoonView(_totemPointLocationList,refreshGlowFilter,refreshTotemPoint);
         _propertyTxtSprite = new TotemLeftWindowPropertyTxtView();
         PositionUtils.setPos(_propertyTxtSprite,"totem.leftView.propertyTxtPos");
         _lineShape = new Shape();
         addChild(_lineShape);
         _lightGlowFilter = new GlowFilter(52479,1,20,20,2,2);
         _grayGlowFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         _tipView = new TotemPointTipView();
         _tipView.visible = false;
         LayerManager.Instance.addToLayer(_tipView,2);
      }
      
      public function refreshView(nextPointInfo:TotemDataVo, callback:Function = null) : void
      {
         _openCartoonSprite.refreshView(nextPointInfo,callback);
      }
      
      public function openFailHandler(nextPointInfo:TotemDataVo) : void
      {
         _openCartoonSprite.failRefreshView(nextPointInfo,enableCurCanClickBtn);
      }
      
      private function enableCurCanClickBtn() : void
      {
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].mouseChildren = true;
            _totemPointList[_curCanClickPointLocation - 1].mouseEnabled = true;
         }
      }
      
      private function disenableCurCanClickBtn() : void
      {
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].mouseChildren = false;
            _totemPointList[_curCanClickPointLocation - 1].mouseEnabled = false;
         }
      }
      
      public function show(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void
      {
         if(page == 0)
         {
            page = 1;
         }
         clip_activeBg.index = page - 1;
         drawLine(page,nextPointInfo,isSelf);
         addTotemPoint(_totemPointLocationList[page - 1],page,nextPointInfo,isSelf);
         addChild(_openCartoonSprite);
         addChild(_propertyTxtSprite);
      }
      
      private function addTotemPoint(location:Array, page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void
      {
         var i:int = 0;
         var bg:* = null;
         var icon:* = null;
         var tmpSprite:* = null;
         if(_totemPointSprite)
         {
            if(_curCanClickPointLocation != 0 && _totemPointList)
            {
               _totemPointList[_curCanClickPointLocation - 1].useHandCursor = false;
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("click",openTotem);
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("mouseOver",showTip);
               _totemPointList[_curCanClickPointLocation - 1].removeEventListener("mouseOut",hideTip);
               _curCanClickPointLocation = 0;
            }
            if(_totemPointSprite.parent)
            {
               _totemPointSprite.parent.removeChild(_totemPointSprite);
            }
            _totemPointSprite = null;
         }
         if(_totemPointList)
         {
            var _loc13_:int = 0;
            var _loc12_:* = _totemPointList;
            for each(var tmpCell in _totemPointList)
            {
               tmpCell.removeEventListener("mouseOver",showTip);
               tmpCell.removeEventListener("mouseOut",hideTip);
               ObjectUtils.disposeObject(tmpCell);
            }
            _totemPointList = null;
         }
         _totemPointSprite = new Sprite();
         _totemPointList = new Vector.<TotemLeftWindowTotemCell>();
         var bgBitmapData:BitmapData = _totemPointBgList[page - 1];
         var len:int = location.length;
         for(i = 0; i < len; )
         {
            bg = new Bitmap(bgBitmapData,"auto",true);
            icon = new Bitmap(_totemPointIconList[i],"auto",true);
            tmpSprite = new TotemLeftWindowTotemCell(bg,icon);
            tmpSprite.x = location[i].x - 46;
            tmpSprite.y = location[i].y - 53;
            tmpSprite.addEventListener("mouseOver",showTip,false,0,true);
            tmpSprite.addEventListener("mouseOut",hideTip,false,0,true);
            tmpSprite.index = i + 1;
            tmpSprite.isCurCanClick = false;
            _totemPointSprite.addChild(tmpSprite);
            _totemPointList.push(tmpSprite);
            i++;
         }
         _propertyTxtSprite.show(location);
         refreshTotemPoint(page,nextPointInfo,isSelf);
         PositionUtils.setPos(_totemPointSprite,"totem.leftView.totemPointSpriPos");
         addChild(_totemPointSprite);
      }
      
      private function refreshGlowFilter(page:int, nextPointInfo:TotemDataVo) : void
      {
         var i:int = 0;
         var len:int = _totemPointList.length;
         for(i = 0; i < len; )
         {
            if(!nextPointInfo || page < nextPointInfo.Page || i + 1 < nextPointInfo.Location)
            {
               _totemPointList[i].setBgIconSpriteFilter([_lightGlowFilter]);
               _totemPointList[i].isHasLighted = true;
            }
            else
            {
               _totemPointList[i].setBgIconSpriteFilter([_grayGlowFilter]);
               _totemPointList[i].isHasLighted = false;
            }
            i++;
         }
      }
      
      private function refreshTotemPoint(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void
      {
         var tmp:int = 0;
         var tmpLocation:int = 0;
         var tmpLevel:int = 0;
         var i:int = 0;
         drawLine(page,nextPointInfo,isSelf);
         refreshGlowFilter(page,nextPointInfo);
         if(_curCanClickPointLocation != 0)
         {
            tmp = _curCanClickPointLocation - 1;
            _totemPointList[tmp].dimOutHalo();
            _totemPointList[tmp].hideLigthCross();
            _totemPointList[tmp].removeEventListener("click",openTotem);
            _totemPointList[tmp].useHandCursor = false;
            _totemPointList[tmp].buttonMode = false;
            _totemPointList[tmp].mouseChildren = true;
            _totemPointList[tmp].mouseEnabled = true;
            _totemPointList[tmp].isCurCanClick = false;
            _curCanClickPointLocation = 0;
         }
         if(isSelf && nextPointInfo && page == nextPointInfo.Page)
         {
            tmpLocation = nextPointInfo.Location - 1;
            _totemPointList[tmpLocation].brightenHalo();
            _totemPointList[tmpLocation].showLigthCross();
            _totemPointList[tmpLocation].useHandCursor = true;
            _totemPointList[tmpLocation].buttonMode = true;
            _totemPointList[tmpLocation].mouseChildren = true;
            _totemPointList[tmpLocation].mouseEnabled = true;
            _totemPointList[tmpLocation].addEventListener("click",openTotem,false,0,true);
            _totemPointList[tmpLocation].isCurCanClick = true;
            _curCanClickPointLocation = nextPointInfo.Location;
         }
         if(!nextPointInfo || page < nextPointInfo.Page)
         {
            tmpLevel = page * 10;
         }
         else
         {
            tmpLevel = (page - 1) * 10 + nextPointInfo.Layers;
         }
         _propertyTxtSprite.refreshLayer(tmpLevel);
         var len:int = _totemPointList.length;
         for(i = 0; i < len; )
         {
            _totemPointList[i].level = tmpLevel;
            i++;
         }
      }
      
      public function scalePropertyTxtSprite(scale:Number) : void
      {
         if(_propertyTxtSprite)
         {
            _propertyTxtSprite.scaleTxt(scale);
         }
      }
      
      private function openTotem(event:MouseEvent) : void
      {
         var totemSignCount3:Number = NaN;
         var alert:* = null;
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var nextInfo:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         var totemSignCount:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
         if(DragonBoatManager.instance.isBuildEnd)
         {
            totemSignCount3 = Math.round(nextInfo.DiscountMoney);
         }
         else
         {
            totemSignCount3 = Math.round(nextInfo.ConsumeExp);
         }
         var moneyCount:int = totemSignCount3 - totemSignCount;
         if(PlayerManager.Instance.Self.myHonor < nextInfo.ConsumeHonor || totemSignCount + PlayerManager.Instance.Self.Money < totemSignCount3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorOrExpUnenough"));
            return;
         }
         if(PlayerManager.Instance.Self.myHonor >= nextInfo.ConsumeHonor && totemSignCount < totemSignCount3 && PlayerManager.Instance.Self.Money >= moneyCount && totemSignCount > 0)
         {
            if(!TotemManager.instance.isDonotPromptActPro)
            {
               if(PlayerManager.Instance.Self.myHonor < nextInfo.ConsumeHonor || totemSignCount + PlayerManager.Instance.Self.Money < totemSignCount3)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.totem.honorOrExpUnenough"));
                  TotemManager.instance.isDonotPromptActPro = true;
               }
               else
               {
                  doOpenOneTotem(false);
                  return;
               }
            }
            alert = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.totem.activateProtectTipTxt3",moneyCount),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,1);
            _selectBtn = ComponentFactory.Instance.creatComponentByStylename("ddtGame.buyConfirmNo.scb");
            _selectBtn.text = LanguageMgr.GetTranslation("horseRace.match.notTip");
            _selectBtn.addEventListener("click",__onClickSelectedBtn);
            alert.addToContent(_selectBtn);
            alert.moveEnable = false;
            alert.addEventListener("response",__openOneTotemConfirms);
            alert.height = 200;
            _selectBtn.x = 32;
            _selectBtn.y = 67;
         }
         else
         {
            doOpenOneTotem(false);
         }
      }
      
      private function __onClickSelectedBtn(e:MouseEvent) : void
      {
         TotemManager.instance.isDonotPromptActPro = !_selectBtn.selected;
      }
      
      private function __openOneTotemConfirms(evt:FrameEvent) : void
      {
         var totemSignCount3:Number = NaN;
         SoundManager.instance.play("008");
         var confirmFrame:BaseAlerFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__openOneTotemConfirm);
         var totemSignCounts:int = PlayerManager.Instance.Self.getBag(1).getItemCountByTemplateId(30000,true);
         var nextInfo:TotemDataVo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
         if(DragonBoatManager.instance.isBuildEnd)
         {
            totemSignCount3 = Math.round(nextInfo.DiscountMoney);
         }
         else
         {
            totemSignCount3 = Math.round(nextInfo.ConsumeExp);
         }
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            if(totemSignCounts + PlayerManager.Instance.Self.Money < totemSignCount3)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            doOpenOneTotem(false);
         }
         else if(evt.responseCode == 4 || evt.responseCode == 0 || evt.responseCode == 1)
         {
            TotemManager.instance.isDonotPromptActPro = true;
         }
         (evt.currentTarget as BaseAlerFrame).removeEventListener("response",__openOneTotemConfirms);
         if(_selectBtn)
         {
            _selectBtn.removeEventListener("click",__onClickSelectedBtn);
         }
         ObjectUtils.disposeObject(evt.currentTarget);
      }
      
      protected function onCheckCancel() : void
      {
         TotemManager.instance.isDonotPromptActPro = false;
         var confirmFrame:BaseAlerFrame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("ddt.totem.activateProtectTipTxt2"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,1,null,"TotemActProConfirmFrame",30,true,1);
         confirmFrame.moveEnable = false;
         confirmFrame.addEventListener("response",__openOneTotemConfirm,false,0,true);
      }
      
      protected function onCheckComplete() : void
      {
         doOpenOneTotem(CheckMoneyUtils.instance.isBind);
      }
      
      private function __openOneTotemConfirm(evt:FrameEvent) : void
      {
         var nextInfo:* = null;
         SoundManager.instance.play("008");
         confirmFrame = evt.currentTarget as BaseAlerFrame;
         confirmFrame.removeEventListener("response",__openOneTotemConfirm);
         if(evt.responseCode == 3 || evt.responseCode == 2)
         {
            nextInfo = TotemManager.instance.getNextInfoById(PlayerManager.Instance.Self.totemId);
            if(nextInfo.Random < 100)
            {
               CheckMoneyUtils.instance.checkMoney(confirmFrame.isBand,1000,onCheckComplete2);
            }
            else
            {
               if((confirmFrame as TotemActProConfirmFrame).isNoPrompt)
               {
                  TotemManager.instance.isDonotPromptActPro = true;
                  TotemManager.instance.isBindInNoPrompt = confirmFrame.isBand;
               }
               doOpenOneTotem(confirmFrame.isBand);
            }
         }
      }
      
      protected function onCheckComplete2() : void
      {
         if((confirmFrame as TotemActProConfirmFrame).isNoPrompt)
         {
            TotemManager.instance.isDonotPromptActPro = true;
            TotemManager.instance.isBindInNoPrompt = confirmFrame.isBand;
         }
         doOpenOneTotem(CheckMoneyUtils.instance.isBind);
      }
      
      private function doOpenOneTotem(isBind:Boolean) : void
      {
         if(!PlayerManager.Instance.Self.IsWeakGuildFinish(101))
         {
            if(PlayerManager.Instance.Self.Grade >= 22)
            {
               SocketManager.Instance.out.syncWeakStep(101);
               NewHandContainer.Instance.clearArrowByID(145);
            }
         }
         disenableCurCanClickBtn();
         SocketManager.Instance.out.sendOpenOneTotem(TotemManager.instance.isSelectedActPro,isBind);
      }
      
      private function showTip(event:MouseEvent) : void
      {
         var totemPoint:TotemLeftWindowTotemCell = event.currentTarget as TotemLeftWindowTotemCell;
         var tmpPoint:Point = this.localToGlobal(new Point(totemPoint.x + totemPoint.bgIconWidth + 10,totemPoint.y));
         _tipView.x = tmpPoint.x;
         _tipView.y = tmpPoint.y;
         var curInfo:TotemDataVo = TotemManager.instance.getCurInfoByLevel((totemPoint.level - 1) * 7 + totemPoint.index);
         _tipView.show(curInfo,totemPoint.isCurCanClick,totemPoint.isHasLighted);
         _tipView.visible = true;
      }
      
      private function hideTip(event:MouseEvent) : void
      {
         _tipView.visible = false;
      }
      
      private function drawTestPoint() : void
      {
         var i:int = 0;
         var j:int = 0;
         var shape:Shape = new Shape();
         for(i = 1; i <= 7; )
         {
            for(j = 1; j <= 10; )
            {
               shape.graphics.beginFill(16711680,0.6);
               shape.graphics.drawCircle(j * 50,i * 50,10);
               shape.graphics.endFill();
               j++;
            }
            i++;
         }
         addChild(shape);
      }
      
      private function drawLine(page:int, nextPointInfo:TotemDataVo, isSelf:Boolean) : void
      {
         var i:int = 0;
         _lineShape.graphics.clear();
         var location:Array = _totemPointLocationList[page - 1];
         var len:int = 0;
         if(!nextPointInfo || page < nextPointInfo.Page)
         {
            len = location.length;
         }
         else if(isSelf)
         {
            len = nextPointInfo.Location;
         }
         else
         {
            len = nextPointInfo.Location;
         }
         _lineShape.graphics.lineStyle(2.7,4321279,0.2);
         _lineShape.graphics.moveTo(location[0].x,location[0].y);
         for(i = 1; i < len; )
         {
            _lineShape.graphics.lineTo(location[i].x,location[i].y);
            i++;
         }
         _lineShape.filters = [new GlowFilter(65532,1,8,8)];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         var _loc5_:int = 0;
         var _loc4_:* = _totemPointBgList;
         for each(var tmp in _totemPointBgList)
         {
            tmp.dispose();
         }
         _totemPointBgList = null;
         var _loc7_:int = 0;
         var _loc6_:* = _totemPointIconList;
         for each(var tmp2 in _totemPointIconList)
         {
            tmp2.dispose();
         }
         _totemPointIconList = null;
         _totemPointSprite = null;
         if(_curCanClickPointLocation != 0 && _totemPointList)
         {
            _totemPointList[_curCanClickPointLocation - 1].useHandCursor = false;
            _totemPointList[_curCanClickPointLocation - 1].removeEventListener("click",openTotem);
            _curCanClickPointLocation = 0;
         }
         if(_totemPointList)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _totemPointList;
            for each(var tmpCell in _totemPointList)
            {
               tmpCell.removeEventListener("mouseOver",showTip);
               tmpCell.removeEventListener("mouseOut",hideTip);
               ObjectUtils.disposeObject(tmpCell);
            }
         }
         _totemPointList = null;
         _lineShape = null;
         _lightGlowFilter = null;
         _grayGlowFilter = null;
         _windowBorder = null;
         _propertyTxtSprite = null;
         ObjectUtils.disposeObject(_tipView);
         _tipView = null;
         ObjectUtils.disposeObject(_openCartoonSprite);
         _openCartoonSprite = null;
      }
   }
}
