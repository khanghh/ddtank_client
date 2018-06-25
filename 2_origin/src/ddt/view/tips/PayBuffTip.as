package ddt.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import ddt.data.BuffInfo;
   import flash.events.Event;
   
   public class PayBuffTip extends BuffTip
   {
       
      
      private var _buffContainer:VBox;
      
      private var _describe:String;
      
      public function PayBuffTip()
      {
         super();
         _buffContainer = ComponentFactory.Instance.creatComponentByStylename("asset.core.PayBuffTipContainer");
         addChild(_buffContainer);
         _activeSp.visible = false;
         addEventListener("removedFromStage",__leaveStage);
      }
      
      private function __leaveStage(event:Event) : void
      {
         _buffContainer.disposeAllChildren();
      }
      
      override protected function drawNameField() : void
      {
         name_txt = ComponentFactory.Instance.creat("core.PayBuffTipNameTxt");
         addChild(name_txt);
      }
      
      override protected function setShow(isActive:Boolean, isFree:Boolean, day:int, hour:int, min:int, describe:String) : void
      {
         _active = isActive;
         _describe = describe;
         _buffContainer.disposeAllChildren();
         if(_active)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _tempData.linkBuffs;
            for each(var buff in _tempData.linkBuffs)
            {
               if(buff is BuffInfo)
               {
                  if(buff.Type != 70 && buff.valided)
                  {
                     _buffContainer.addChild(new PayBuffListItem(buff));
                  }
               }
               else
               {
                  _buffContainer.addChild(new PayBuffListItem(buff));
               }
            }
         }
         updateTxt();
         updateWH();
      }
      
      private function updateTxt() : void
      {
         if(_active)
         {
            name_txt.text = _tempData.name;
            setChildIndex(name_txt,numChildren - 1);
            describe_txt.visible = false;
            name_txt.visible = true;
         }
         else
         {
            describe_txt.text = _describe;
            describe_txt.visible = true;
            name_txt.visible = false;
         }
      }
      
      override protected function updateWH() : void
      {
         if(_active)
         {
            _bg.width = _buffContainer.x + _buffContainer.width + _buffContainer.x;
            _bg.height = _buffContainer.y + _buffContainer.height + 16;
         }
         else
         {
            _bg.width = int(describe_txt.x + describe_txt.width);
            _bg.height = int(describe_txt.y + describe_txt.height + 10);
         }
         _width = _bg.width;
         _height = _bg.height;
      }
   }
}
