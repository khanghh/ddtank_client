package treasureHunting.items
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   
   public class LuckRankItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _selectedBg:ScaleLeftRightImage;
      
      private var _sortText:FilterFrameText;
      
      private var _nameText:FilterFrameText;
      
      private var _numberText:FilterFrameText;
      
      public function LuckRankItem(param1:int){super();}
      
      private function initView(param1:int) : void{}
      
      public function update(param1:int, param2:String, param3:int) : void{}
      
      public function set selected(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
