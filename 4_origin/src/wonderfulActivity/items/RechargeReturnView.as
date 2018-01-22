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
      
      public function RechargeReturnView(param1:int = 0, param2:ActivityTypeData = null)
      {
         super();
         _type = param1;
         _data = param2;
         _stateList = WonderfulActivityManager.Instance._stateList;
      }
      
      public function setState(param1:int, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = _listRightItem.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_listRightItem[_loc4_].getItemID() == param2)
            {
               if(param1 > 0)
               {
                  _listRightItem[_loc4_].initBtnState(1,param1);
                  _listRightItem[_loc4_].setBtnTxt(param1);
               }
               else if(param1 == -1)
               {
                  _listRightItem[_loc4_].initBtnState();
                  applyGray(_listRightItem[_loc4_].getBtn());
               }
               else
               {
                  _listRightItem[_loc4_].initBtnState(0);
                  applyGray(_listRightItem[_loc4_].getBtn());
                  _listRightItem[_loc4_].getBtn().mouseEnabled = false;
                  _listRightItem[_loc4_].getBtn().mouseChildren = false;
               }
               break;
            }
            _loc4_++;
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
      
      private function applyGray(param1:DisplayObject) : void
      {
         var _loc2_:Array = [];
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0.3086,0.6094,0.082,0,0]);
         _loc2_ = _loc2_.concat([0,0,0,1,0]);
         applyFilter(param1,_loc2_);
      }
      
      private function applyFilter(param1:DisplayObject, param2:Array) : void
      {
         var _loc4_:ColorMatrixFilter = new ColorMatrixFilter(param2);
         var _loc3_:Array = [];
         _loc3_.push(_loc4_);
         param1.filters = _loc3_;
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
         var _loc1_:String = WonderfulActivityManager.Instance.getTimeDiff(endData,nowdate);
         _timerTxt.text = _loc1_;
         if(_loc1_ == "0")
         {
            dispose();
            WonderfulActivityManager.Instance.delTimerFun("recharge");
            SocketManager.Instance.out.sendWonderfulActivity(0,-1);
            WonderfulActivityManager.Instance.currView = "-1";
         }
      }
      
      private function initItem() : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:int = _list.length;
         _loc5_ = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = 0;
            while(_loc4_ < _stateList.length)
            {
               if(_list[_loc5_].ID == _stateList[_loc4_].id)
               {
                  _loc3_ = _loc5_ % 2;
                  _loc1_ = new RightListItem(_loc3_,_list[_loc5_]);
                  if(_stateList[_loc4_].num == 0)
                  {
                     _loc1_.initBtnState(0);
                     applyGray(_loc1_.getBtn());
                     _loc1_.getBtn().mouseEnabled = false;
                  }
                  else if(_stateList[_loc4_].num == -1)
                  {
                     _loc1_.initBtnState();
                     applyGray(_loc1_.getBtn());
                     _loc1_.getBtn().mouseEnabled = false;
                  }
                  else if(_stateList[_loc4_].num >= 1)
                  {
                     _loc1_.initBtnState(1,_stateList[_loc4_].num);
                     _loc1_.setBtnTxt(_stateList[_loc4_].num);
                  }
                  _listRightItem.push(_loc1_);
                  _vbox.addChild(_loc1_);
                  break;
               }
               _loc4_++;
            }
            _loc5_++;
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
