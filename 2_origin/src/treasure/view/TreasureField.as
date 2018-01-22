package treasure.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import treasure.controller.TreasureManager;
   import treasure.events.TreasureEvents;
   import treasure.model.TreasureModel;
   
   public class TreasureField extends Sprite implements Disposeable
   {
       
      
      private var X:Number = 236;
      
      private var Y:Number = 281;
      
      private var W:Number = 61;
      
      private var H:Number = 45;
      
      private var _fieldList:Vector.<TreasureCell>;
      
      private var cartoon:MovieClip;
      
      private var _fieldMc:MovieClip;
      
      private var _fieldMcList:Array;
      
      public function TreasureField(param1:Sprite)
      {
         super();
         param1.addChild(this);
         initListener();
      }
      
      private function initListener() : void
      {
         TreasureManager.instance.addEventListener("fieldChange",__fieldChangeHandler);
      }
      
      public function setField(param1:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = null;
         creatField();
         _fieldList = new Vector.<TreasureCell>();
         var _loc2_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < 4)
         {
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               _loc3_ = new TreasureCell(_loc2_ + 1,param1);
               _loc3_.x = X + (_loc3_.width + 2 - W) * _loc5_ + W * _loc4_;
               _loc3_.y = Y + (_loc3_.height - 4 - H) * _loc5_ - H * _loc4_;
               addChild(_loc3_);
               _loc3_.addEvent();
               _fieldList.push(_loc3_);
               _loc2_++;
               _loc4_++;
            }
            _loc5_++;
         }
      }
      
      private function creatField() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _fieldMcList = [];
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               _fieldMc = ComponentFactory.Instance.creat("asset.treasure.field");
               _fieldMc.x = X + (_fieldMc.width + 2 - W) * _loc3_ + W * _loc2_;
               _fieldMc.y = Y + (_fieldMc.height - 4 - H) * _loc3_ - H * _loc2_;
               if(TreasureModel.instance.itemList[_loc1_].pos > 0)
               {
                  _fieldMc.gotoAndStop(2);
               }
               else
               {
                  _fieldMc.gotoAndStop(1);
               }
               addChild(_fieldMc);
               _fieldMcList.push(_fieldMc);
               _loc1_++;
               _loc2_++;
            }
            _loc3_++;
         }
      }
      
      private function __fieldChangeHandler(param1:TreasureEvents) : void
      {
         _fieldMcList[param1.info.pos - 1].gotoAndStop(2);
      }
      
      public function endGameShow() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _fieldList.length)
         {
            if(TreasureModel.instance.itemList[_fieldList[_loc1_]._fieldPos - 1].pos == 0)
            {
               _fieldList[_loc1_].creatCartoon("end");
            }
            _loc1_++;
         }
      }
      
      public function playStartCartoon() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _fieldList.length)
         {
            _fieldList[_loc3_].cartoon.visible = false;
            _loc3_++;
         }
         cartoon = ComponentFactory.Instance.creat("asset.treasure.cartoon2");
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,43,43);
         _loc1_.graphics.endFill();
         _loc4_ = 1;
         while(_loc4_ <= TreasureModel.instance.itemList.length)
         {
            _loc2_ = new TreasureFieldCell(_loc1_,TreasureModel.instance.itemList[_loc4_ - 1]);
            cartoon["mc" + _loc4_].addChild(_loc2_);
            _loc4_++;
         }
         addChild(cartoon);
         PositionUtils.setPos(cartoon,"cartoon2.pos");
         cartoon.addEventListener("enterFrame",onCompleteHandeler);
      }
      
      public function digField(param1:int) : void
      {
         swapChildren(_fieldList[param1 - 1],_fieldList[_fieldList.length - 1]);
         _fieldList[param1 - 1].digBackHandler();
      }
      
      private function onCompleteHandeler(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(cartoon != null && cartoon.currentFrame == cartoon.totalFrames)
         {
            cartoon.removeEventListener("enterFrame",onCompleteHandeler);
            if(cartoon)
            {
               ObjectUtils.disposeObject(cartoon);
            }
            cartoon = null;
            _loc2_ = 0;
            while(_loc2_ < _fieldList.length)
            {
               _fieldList[_loc2_].addEvent();
               _loc2_++;
            }
         }
      }
      
      private function removeListener() : void
      {
         TreasureManager.instance.removeEventListener("fieldChange",__fieldChangeHandler);
      }
      
      public function dispose() : void
      {
         removeListener();
         if(cartoon)
         {
            ObjectUtils.disposeObject(cartoon);
         }
         cartoon = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
