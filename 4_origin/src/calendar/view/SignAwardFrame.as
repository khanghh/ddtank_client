package calendar.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.DaylyGiveInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   
   public class SignAwardFrame extends BaseAlerFrame
   {
       
      
      private var _back:DisplayObject;
      
      private var _awardCells:Vector.<SignAwardCell>;
      
      private var _awards:Array;
      
      private var _signCount:int;
      
      public function SignAwardFrame()
      {
         _awardCells = new Vector.<SignAwardCell>();
         super();
         configUI();
      }
      
      private function __response(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         removeEventListener("response",__response);
         ObjectUtils.disposeObject(this);
      }
      
      public function show(param1:int, param2:Array) : void
      {
         var _loc5_:* = null;
         _signCount = param1;
         _awards = param2;
         var _loc4_:Point = ComponentFactory.Instance.creatCustomObject("Calendar.SignAward.TopLeft");
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = _awards;
         for each(var _loc6_ in _awards)
         {
            _loc5_ = ComponentFactory.Instance.creatCustomObject("SignAwardCell");
            _awardCells.push(_loc5_);
            _loc5_.info = ItemManager.Instance.getTemplateById(_loc6_.TemplateID);
            _loc5_.setCount(_loc6_.Count);
            if(_loc3_ % 2 == 0)
            {
               _loc5_.x = _loc4_.x;
               _loc5_.y = _loc4_.y + _loc7_ * 64;
            }
            else
            {
               _loc5_.x = _loc4_.x + 139;
               _loc5_.y = _loc4_.y + _loc7_ * 64;
               _loc7_++;
            }
            addToContent(_loc5_);
            _loc3_++;
         }
         addEventListener("response",__response);
      }
      
      private function configUI() : void
      {
         info = new AlertInfo(LanguageMgr.GetTranslation("tank.calendar.sign.title"),LanguageMgr.GetTranslation("ok"),"",true,false);
         _back = ComponentFactory.Instance.creatComponentByStylename("Calendar.SignAward.Back");
         addToContent(_back);
      }
      
      override public function dispose() : void
      {
         while(_awardCells.length > 0)
         {
            ObjectUtils.disposeObject(_awardCells.shift());
         }
         ObjectUtils.disposeObject(_back);
         _back = null;
         super.dispose();
      }
   }
}
