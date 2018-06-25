package consortiaDomain.view
{
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class BuildsStateView extends Sprite implements Disposeable
   {
       
      
      public function BuildsStateView()
      {
         var i:int = 0;
         var cell:* = null;
         super();
         UICreatShortcut.creatAndAdd("consortiadomain.buildStateView.bg",this);
         var buidIdArr:Array = [5,4,2,1,3];
         for(i = 0; i < 5; )
         {
            cell = new BuildsStateCell(buidIdArr[i]);
            cell.x = 6;
            cell.y = i * 20 + 6;
            addChild(cell);
            i++;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
