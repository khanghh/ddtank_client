package dayActivity.items
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import dayActivity.DayActivityManager;
   import dayActivity.DayRewaidData;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class DayActivityRightViewItem extends Sprite implements Disposeable
   {
       
      
      public var id:int;
      
      private var _back:ScaleBitmapImage;
      
      private var _txt1:FilterFrameText;
      
      private var _list:Vector.<BagCell>;
      
      private var _btn1:SimpleBitmapButton;
      
      private var _btn2:SimpleBitmapButton;
      
      private var _lightBitMap:MovieClip;
      
      public function DayActivityRightViewItem(param1:int)
      {
         super();
         initView(param1);
      }
      
      private function initView(param1:int) : void
      {
         _list = new Vector.<BagCell>();
         _back = ComponentFactory.Instance.creatComponentByStylename("dayActivityView.right.itemBack");
         addChild(_back);
         _lightBitMap = ComponentFactory.Instance.creat("day.receiveLight");
         _lightBitMap.x = 284;
         _lightBitMap.y = 13;
         _lightBitMap.visible = false;
         addChild(_lightBitMap);
         _txt1 = ComponentFactory.Instance.creatComponentByStylename("day.activityView.right.itemTxt");
         _txt1.text = LanguageMgr.GetTranslation("ddt.dayActivity.needActivity",param1);
         addChild(_txt1);
         _btn1 = ComponentFactory.Instance.creatComponentByStylename("dayActivity.day.receiveBtn");
         _btn1.addEventListener("click",clickHander);
         addChild(_btn1);
         _btn1.visible = false;
         _btn2 = ComponentFactory.Instance.creatComponentByStylename("dayActivity.receiveOverBtn");
         _btn2.visible = false;
         addChild(_btn2);
         initGoods(DayActivityManager.Instance.reweadDataList,param1);
      }
      
      private function clickHander(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         SocketManager.Instance.out.sendGetGoods(id);
      }
      
      public function showBtn(param1:Boolean) : void
      {
         _txt1.visible = false;
         _btn2.visible = false;
         _btn1.visible = false;
         _lightBitMap.visible = false;
         if(param1)
         {
            _btn2.visible = true;
            _btn2.enable = false;
            applyGray(this);
         }
         else
         {
            _btn1.visible = true;
            _btn1.enable = true;
            _lightBitMap.visible = true;
         }
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
      
      private function initGoods(param1:Vector.<DayRewaidData>, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         if(!param1)
         {
            return;
         }
         var _loc6_:int = param1.length;
         var _loc3_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(param2 == DayActivityManager.Instance.reweadDataList[_loc8_].RewardID)
            {
               _loc4_ = new BagCell(_loc8_);
               _loc5_ = ComponentFactory.Instance.creat("dayActivityView.right.goodsBack");
               _loc7_ = ItemManager.Instance.getTemplateById(DayActivityManager.Instance.reweadDataList[_loc8_].RewardItemID);
               _loc4_.info = _loc7_;
               addChild(_loc5_);
               addChild(_loc4_);
               _loc5_.x = (_loc5_.width + 4) * _loc3_ + 10;
               _loc5_.y = _back.height / 2 - _loc5_.height / 2;
               _loc4_.x = _loc5_.x + 2.5;
               _loc4_.y = _loc5_.y + 2.5;
               _loc3_++;
               _loc4_.setCount(DayActivityManager.Instance.reweadDataList[_loc8_].RewardItemCount);
               _list.push(_loc4_);
            }
            _loc8_++;
         }
      }
      
      public function dispose() : void
      {
         _btn1.removeEventListener("click",clickHander);
         while(numChildren)
         {
            ObjectUtils.disposeObject(getChildAt(0));
         }
         if(parent)
         {
            parent.removeChild(this);
         }
         _list = null;
      }
   }
}
