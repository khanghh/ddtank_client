package wonderfulActivity.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.ActivityTypeData;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.filters.ColorMatrixFilter;
   import wonderfulActivity.WonderfulActivityManager;
   import wonderfulActivity.data.CanGetData;
   import wonderfulActivity.views.IRightView;
   
   public class RechargeReturnView extends Sprite implements IRightView
   {
       
      
      private var _goldLine:Bitmap;
      
      private var _tittle:Bitmap;
      
      private var _goldStone:Bitmap;
      
      private var _back:Bitmap;
      
      private var _vbox:VBox;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _downBack:Bitmap;
      
      private var _limitTime:Bitmap;
      
      private var _type:int;
      
      private var _downTxt:FilterFrameText;
      
      private var _list:Vector.<ActivityTypeData>;
      
      private var _listRightItem:Vector.<RightListItem>;
      
      private var _timerTxt:FilterFrameText;
      
      private var _helpIcon:ScaleBitmapImage;
      
      private var _data:ActivityTypeData;
      
      private var startData:Date;
      
      private var endData:Date;
      
      private var nowdate:Date;
      
      private var _stateList:Vector.<CanGetData>;
      
      private var _isTimerOver:Boolean = false;
      
      public function RechargeReturnView(type:int = 0, data:ActivityTypeData = null)
      {
         super();
         _type = type;
         _data = data;
         _stateList = WonderfulActivityManager.Instance._stateList;
      }
      
      public function setState(type:int, id:int) : void
      {
         var i:int = 0;
         var len:int = _listRightItem.length;
         for(i = 0; i < len; )
         {
            if(_listRightItem[i].getItemID() == id)
            {
               if(type > 0)
               {
                  _listRightItem[i].initBtnState(1,type);
                  _listRightItem[i].setBtnTxt(type);
               }
               else if(type == -1)
               {
                  _listRightItem[i].initBtnState();
                  applyGray(_listRightItem[i].getBtn());
               }
               else
               {
                  _listRightItem[i].initBtnState(0);
                  applyGray(_listRightItem[i].getBtn());
                  _listRightItem[i].getBtn().mouseEnabled = false;
                  _listRightItem[i].getBtn().mouseChildren = false;
               }
               break;
            }
            i++;
         }
      }
      
      public function init() : void
      {
         _goldLine = ComponentFactory.Instance.creat("wonderfulactivity.libao.goldLine");
         addChild(_goldLine);
         _back = ComponentFactory.Instance.creat("wonderfulactivity.fame.back");
         addChild(_back);
         _goldStone = ComponentFactory.Instance.creat("wonderfulactivity.libao.gold");
         addChild(_goldStone);
         _downBack = ComponentFactory.Instance.creat("wonderfulactivity.right.back");
         addChild(_downBack);
         _timerTxt = ComponentFactory.Instance.creat("wonderfulactivity.right.timeTxt");
         addChild(_timerTxt);
         _downTxt = ComponentFactory.Instance.creat("wonderfulactivity.right.desTxt");
         addChild(_downTxt);
         if(_type == 1)
         {
            _tittle = ComponentFactory.Instance.creat("wonderfulactivity.rechargeTille1");
            _list = WonderfulActivityManager.Instance.activityRechargeList;
            _downTxt.text = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt7",WonderfulActivityManager.Instance.chongZhiScore);
         }
         else
         {
            _helpIcon = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.helpImg");
            _helpIcon.tipData = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt8_tip");
            addChild(_helpIcon);
            _tittle = ComponentFactory.Instance.creat("wonderfulactivity.rechargeTille2");
            _list = WonderfulActivityManager.Instance.activityExpList;
            _downTxt.text = LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt8",WonderfulActivityManager.Instance.xiaoFeiScore);
         }
         addChild(_tittle);
         _limitTime = ComponentFactory.Instance.creat("wonderfulactivity.limit");
         addChild(_limitTime);
         _vbox = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.left.vBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("wonderfulactivity.right.scrollpanel");
         _scrollPanel.setView(_vbox);
         _scrollPanel.invalidateViewport();
         addChild(_scrollPanel);
         _listRightItem = new Vector.<RightListItem>();
         initItem();
         initTimer();
      }
      
      private function applyGray(child:DisplayObject) : void
      {
         var matrix:Array = [];
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0.3086,0.6094,0.082,0,0]);
         matrix = matrix.concat([0,0,0,1,0]);
         applyFilter(child,matrix);
      }
      
      private function applyFilter(child:DisplayObject, matrix:Array) : void
      {
         var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
         var filters:Array = [];
         filters.push(filter);
         child.filters = filters;
      }
      
      private function initTimer() : void
      {
         startData = _data.StartTime;
         endData = _data.EndTime;
         rechargeTimerHander();
         WonderfulActivityManager.Instance.addTimerFun("recharge",rechargeTimerHander);
      }
      
      private function rechargeTimerHander() : void
      {
         nowdate = TimeManager.Instance.Now();
         var str:String = WonderfulActivityManager.Instance.getTimeDiff(endData,nowdate);
         _timerTxt.text = str;
         if(str == "0")
         {
            dispose();
            WonderfulActivityManager.Instance.delTimerFun("recharge");
            SocketManager.Instance.out.sendWonderfulActivity(0,-1);
            WonderfulActivityManager.Instance.currView = "-1";
         }
      }
      
      private function initItem() : void
      {
         var i:int = 0;
         var j:int = 0;
         var type:int = 0;
         var item:* = null;
         var len:int = _list.length;
         for(i = 0; i < len; )
         {
            for(j = 0; j < _stateList.length; )
            {
               if(_list[i].ID == _stateList[j].id)
               {
                  type = i % 2;
                  item = new RightListItem(type,_list[i]);
                  if(_stateList[j].num == 0)
                  {
                     item.initBtnState(0);
                     applyGray(item.getBtn());
                     item.getBtn().mouseEnabled = false;
                  }
                  else if(_stateList[j].num == -1)
                  {
                     item.initBtnState();
                     applyGray(item.getBtn());
                     item.getBtn().mouseEnabled = false;
                  }
                  else if(_stateList[j].num >= 1)
                  {
                     item.initBtnState(1,_stateList[j].num);
                     item.setBtnTxt(_stateList[j].num);
                  }
                  _listRightItem.push(item);
                  _vbox.addChild(item);
                  break;
               }
               j++;
            }
            i++;
         }
         _scrollPanel.invalidateViewport();
      }
      
      public function content() : Sprite
      {
         return this;
      }
      
      public function dispose() : void
      {
         WonderfulActivityManager.Instance.delTimerFun("recharge");
         while(this.numChildren)
         {
            ObjectUtils.disposeObject(this.getChildAt(0));
         }
         if(parent)
         {
            ObjectUtils.disposeObject(this);
         }
      }
   }
}
