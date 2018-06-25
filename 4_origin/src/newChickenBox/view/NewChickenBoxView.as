package newChickenBox.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import newChickenBox.data.NewChickenBoxGoodsTempInfo;
   import newChickenBox.model.NewChickenBoxModel;
   
   public class NewChickenBoxView extends Sprite implements Disposeable
   {
      
      private static const NUM:int = 18;
       
      
      private var _model:NewChickenBoxModel;
      
      private var eyeItem:NewChickenBoxItem;
      
      private var frame:BaseAlerFrame;
      
      private var moveBackArr:Array;
      
      public function NewChickenBoxView()
      {
         super();
         _model = NewChickenBoxModel.instance;
         init();
      }
      
      private function init() : void
      {
         moveBackArr = [];
         if(_model.isShowAll)
         {
            getAllItem();
         }
         else
         {
            updataAllItem();
         }
      }
      
      public function getAllItem() : void
      {
         var i:int = 0;
         var stand:* = null;
         var move:* = null;
         var p:* = null;
         var iteminfo:* = null;
         var s:* = null;
         var cell:* = null;
         var bg:* = null;
         var item:* = null;
         var num1:int = Math.random() * 18;
         var num2:int = getNum(num1);
         for(i = 0; i < 18; )
         {
            stand = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            move = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            p = "newChickenBox.itemPos" + i;
            iteminfo = _model.templateIDList[i];
            s = new Sprite();
            s.graphics.beginFill(16777215,0);
            s.graphics.drawRect(0,0,39,39);
            s.graphics.endFill();
            cell = new NewChickenBoxCell(s,iteminfo.info);
            if(i == num1 || i == num2)
            {
               bg = move;
               moveBackArr.push(i);
            }
            else
            {
               bg = stand;
            }
            item = new NewChickenBoxItem(cell,bg);
            item.info = iteminfo;
            item.updateCount();
            item.addEventListener("click",tackoverCard);
            item.position = i;
            PositionUtils.setPos(item,p);
            if(_model.itemList.length == 18)
            {
               _model.itemList[i].dispose();
               _model.itemList[i] = null;
               _model.itemList[i] = item;
            }
            else
            {
               _model.itemList.push(item);
            }
            addChild(item);
            i++;
         }
      }
      
      private function openAlertFrame(item:NewChickenBoxItem) : BaseAlerFrame
      {
         var msg:String = LanguageMgr.GetTranslation("newChickenBox.EagleEye.msg",_model.canEagleEyeCounts - _model.countEye,_model.eagleEyePrice[_model.countEye]);
         var select:SelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.selectBnt3");
         select.text = LanguageMgr.GetTranslation("newChickenBox.noAlert");
         select.addEventListener("click",noAlertEable);
         if(frame)
         {
            ObjectUtils.disposeObject(frame);
         }
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("newChickenBox.newChickenTitle"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         frame.addChild(select);
         frame.addEventListener("response",__onResponse);
         eyeItem = item;
         return frame;
      }
      
      private function noAlertEable(e:MouseEvent) : void
      {
         var select:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         if(select.selected)
         {
            _model.alertEye = false;
         }
         else
         {
            _model.alertEye = true;
         }
      }
      
      private function __onResponse(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            SocketManager.Instance.out.sendChickenBoxUseEagleEye(eyeItem.position);
         }
      }
      
      private function openAlertFrame2(item:NewChickenBoxItem) : BaseAlerFrame
      {
         var msg:String = LanguageMgr.GetTranslation("newChickenBox.OpenCard.msg",_model.openCardPrice[_model.countTime]);
         var select:SelectedCheckButton = ComponentFactory.Instance.creatComponentByStylename("newChickenBox.selectBnt2");
         select.text = LanguageMgr.GetTranslation("newChickenBox.noAlert");
         select.addEventListener("click",noAlertEable2);
         if(frame)
         {
            ObjectUtils.disposeObject(frame);
         }
         frame = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("newChickenBox.newChickenTitle"),msg,LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),true,true,true,2);
         frame.addChild(select);
         frame.addEventListener("response",__onResponse2);
         eyeItem = item;
         return frame;
      }
      
      private function noAlertEable2(e:MouseEvent) : void
      {
         var select:SelectedCheckButton = e.currentTarget as SelectedCheckButton;
         if(select.selected)
         {
            _model.alertOpenCard = false;
         }
         else
         {
            _model.alertOpenCard = true;
         }
      }
      
      private function __onResponse2(evt:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         var alert:BaseAlerFrame = evt.target as BaseAlerFrame;
         alert.removeEventListener("response",__onResponse2);
         alert.dispose();
         if(evt.responseCode == 2 || evt.responseCode == 3)
         {
            SocketManager.Instance.out.sendChickenBoxTakeOverCard(eyeItem.info.Position);
         }
      }
      
      public function getItemEvent(item:NewChickenBoxItem) : void
      {
         item.addEventListener("click",tackoverCard);
      }
      
      public function removeItemEvent(item:NewChickenBoxItem) : void
      {
         item.removeEventListener("click",tackoverCard);
         item.dispose();
      }
      
      public function tackoverCard(e:MouseEvent) : void
      {
         var moneyValue:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var item:NewChickenBoxItem = e.currentTarget as NewChickenBoxItem;
         var info:NewChickenBoxGoodsTempInfo = item.info;
         if(_model.canclickEnable && !info.IsSelected && (!item.cell.visible || item.cell.alpha < 0.9))
         {
            if(_model.clickEagleEye)
            {
               moneyValue = _model.eagleEyePrice[_model.countEye];
               trace(moneyValue,_model.countEye);
               if(PlayerManager.Instance.Self.Money < moneyValue && _model.freeEyeCount <= 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               if(info.IsSeeded)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("newChickenBox.useEyeEnable"));
                  return;
               }
               if(_model.alertEye && _model.freeEyeCount <= 0)
               {
                  if(_model.countEye < _model.canEagleEyeCounts)
                  {
                     _model.dispatchEvent(new Event("mouseShapoff"));
                     openAlertFrame(item);
                  }
                  else
                  {
                     SocketManager.Instance.out.sendChickenBoxUseEagleEye(item.position);
                  }
               }
               else
               {
                  SocketManager.Instance.out.sendChickenBoxUseEagleEye(item.position);
               }
            }
            else
            {
               moneyValue = _model.openCardPrice[_model.countTime];
               trace(moneyValue,_model.countTime);
               if(PlayerManager.Instance.Self.Money < moneyValue && _model.freeOpenCardCount <= 0)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               if(_model.alertOpenCard && _model.freeOpenCardCount <= 0)
               {
                  openAlertFrame2(item);
               }
               else
               {
                  SocketManager.Instance.out.sendChickenBoxTakeOverCard(item.info.Position);
               }
            }
         }
      }
      
      private function getNum(num:int) : int
      {
         var num2:int = Math.random() * 18;
         if(num2 == num)
         {
            getNum(num);
         }
         return num2;
      }
      
      public function updataAllItem() : void
      {
         var i:int = 0;
         var p:* = null;
         var iteminfo:* = null;
         var s:* = null;
         var tmpItemInfo:* = null;
         var cell:* = null;
         var bg:* = null;
         var item:* = null;
         var num1:int = Math.random() * 18;
         var num2:int = getNum(num1);
         for(i = 0; i < _model.templateIDList.length; )
         {
            p = "newChickenBox.itemPos" + i;
            iteminfo = _model.templateIDList[i];
            s = new Sprite();
            s.graphics.beginFill(16777215,0);
            s.graphics.drawRect(0,0,39,39);
            s.graphics.endFill();
            tmpItemInfo = iteminfo.IsSelected || iteminfo.IsSeeded?iteminfo.info:null;
            cell = new NewChickenBoxCell(s,tmpItemInfo);
            if((i == num1 || i == num2) && iteminfo.IsSelected)
            {
               bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenMove") as MovieClip;
            }
            else if(iteminfo.IsSelected)
            {
               bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenStand") as MovieClip;
            }
            else if(iteminfo.IsSeeded)
            {
               bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenBack") as MovieClip;
               cell.visible = true;
               cell.alpha = 0.5;
            }
            else
            {
               bg = ClassUtils.CreatInstance("asset.newChickenBox.chickenBack") as MovieClip;
               cell.visible = false;
            }
            item = new NewChickenBoxItem(cell,bg);
            item.info = iteminfo;
            item.updateCount();
            item.countTextShowIf();
            item.addEventListener("click",tackoverCard);
            item.position = i;
            PositionUtils.setPos(item,p);
            if(_model.itemList.length == 18)
            {
               _model.itemList[i].dispose();
               _model.itemList[i] = null;
               _model.itemList[i] = item;
            }
            else
            {
               _model.itemList.push(item);
            }
            addChild(item);
            i++;
         }
      }
      
      public function dispose() : void
      {
         var i:int = 0;
         var item:* = null;
         if(frame)
         {
            frame.removeEventListener("response",__onResponse);
            frame.dispose();
         }
         i = 0;
         while(i < _model.templateIDList.length)
         {
            item = _model.itemList[i] as NewChickenBoxItem;
            item.dispose();
            item = null;
            i++;
         }
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
