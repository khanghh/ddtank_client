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
      
      private function __response(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         removeEventListener("response",__response);
         ObjectUtils.disposeObject(this);
      }
      
      public function show(signCount:int, awards:Array) : void
      {
         var cell:* = null;
         _signCount = signCount;
         _awards = awards;
         var topleft:Point = ComponentFactory.Instance.creatCustomObject("Calendar.SignAward.TopLeft");
         var row:int = 0;
         var count:int = 0;
         var _loc9_:int = 0;
         var _loc8_:* = _awards;
         for each(var item in _awards)
         {
            cell = ComponentFactory.Instance.creatCustomObject("SignAwardCell");
            _awardCells.push(cell);
            cell.info = ItemManager.Instance.getTemplateById(item.TemplateID);
            cell.setCount(item.Count);
            if(count % 2 == 0)
            {
               cell.x = topleft.x;
               cell.y = topleft.y + row * 64;
            }
            else
            {
               cell.x = topleft.x + 139;
               cell.y = topleft.y + row * 64;
               row++;
            }
            addToContent(cell);
            count++;
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
