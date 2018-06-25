package bagAndInfo.cell
{
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import times.utils.timerManager.TimerManager;
   
   public class CellMCSpecialEffectCreator extends CellContentCreator
   {
       
      
      public function CellMCSpecialEffectCreator()
      {
         super();
      }
      
      override public function loadSync(callBack:Function) : void
      {
         var color:* = null;
         _callBack = callBack;
         if(_info.CategoryID == 10)
         {
            _timer = TimerManager.getInstance().addTimerJuggler(100,1);
            _timer.addEventListener("timerComplete",__timerComplete);
            _timer.start();
         }
         else
         {
            if(_info is InventoryItemInfo)
            {
               color = EquipType.isEditable(_info) && InventoryItemInfo(_info).Color != null?InventoryItemInfo(_info).Color:"";
               _loader = _factory.createLayer(_info,_info.NeedSex == 1,color,"movie_clip_effect");
            }
            else
            {
               _loader = _factory.createLayer(_info,_info.NeedSex == 1,"","movie_clip_effect");
            }
            _loader.load(loadComplete);
         }
      }
   }
}
