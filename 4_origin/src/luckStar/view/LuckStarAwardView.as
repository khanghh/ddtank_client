package luckStar.view
{
   import bagAndInfo.cell.BaseCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import luckStar.manager.LuckStarManager;
   
   public class LuckStarAwardView extends Sprite implements Disposeable
   {
       
      
      private var bg:Bitmap;
      
      private var _closeBtn:BaseButton;
      
      private var _list:Vector.<BaseCell>;
      
      private var _countList:Vector.<FilterFrameText>;
      
      public function LuckStarAwardView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _countList = new Vector.<FilterFrameText>();
         bg = ComponentFactory.Instance.creat("luckyStar.view.AwardListBG");
         _closeBtn = ComponentFactory.Instance.creat("luckyStar.view.RankBtn");
         _closeBtn.addEventListener("click",__onClose);
         addChild(bg);
         addChild(_closeBtn);
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:* = null;
         var _loc4_:Array = [11,12,13,14,15,16];
         var _loc3_:Vector.<InventoryItemInfo> = LuckStarManager.Instance.model.reward;
         var _loc6_:int = _loc3_.length;
         var _loc2_:int = 0;
         _list = new Vector.<BaseCell>(_loc6_);
         while(_loc4_.length)
         {
            _loc5_ = _loc4_.shift();
            _loc2_ = 0;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(_loc3_[_loc7_].Quality == _loc5_)
               {
                  _list[_loc7_] = new BaseCell(ComponentFactory.Instance.creatComponentByStylename("luckyStar.view.awardcellBg"));
                  _list[_loc7_].info = _loc3_[_loc7_];
                  _list[_loc7_].info.Quality = ItemManager.Instance.getTemplateById(_loc3_[_loc7_].TemplateID).Quality;
                  PositionUtils.setPos(_list[_loc7_],"luckyStar.view.awardPos" + _loc5_ + _loc2_);
                  addChild(_list[_loc7_]);
                  if(_loc3_[_loc7_].Count > 1)
                  {
                     _loc1_ = ComponentFactory.Instance.creat("luckyStar.view.cellCount");
                     _loc1_.text = _loc3_[_loc7_].Count.toString();
                     _loc1_.x = _list[_loc7_].x - 12;
                     _loc1_.y = _list[_loc7_].y + 25;
                     addChild(_loc1_);
                     _countList.push(_loc1_);
                  }
                  _loc2_++;
               }
               _loc7_++;
            }
         }
      }
      
      private function __onClose(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         this.parent.removeChild(this);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(bg);
         bg = null;
         _closeBtn.removeEventListener("click",__onClose);
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         while(_list.length)
         {
            ObjectUtils.disposeObject(_list.pop());
         }
         _list = null;
         while(_countList.length)
         {
            ObjectUtils.disposeObject(_countList.pop());
         }
         _countList = null;
      }
   }
}
