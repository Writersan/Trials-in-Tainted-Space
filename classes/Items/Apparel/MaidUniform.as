package classes.Items.Apparel 
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.StringUtil;
	import classes.GameData.TooltipManager;

	public class MaidUniform extends ItemSlotClass
	{
		
		public function MaidUniform() 
		{
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 1;
			this.type = GLOBAL.CLOTHING;
			
			this.shortName = "Maid U.";
			
			this.longName = "maid outfit";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			this.description = "a frilly french maid outfit";
			
			this.tooltip = "A classic outfit worn by servants and the sexually adventurous, everywhere. Consisting of a black and white frilly dress, an attached mock-apron, and thigh-high stockings, it’s made of a waterproof, stain proof material ensuring the maid spends more time cleaning everything else.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			this.basePrice = 2000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.sexiness = 6;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = this._latestVersion;
		}
	}
}
