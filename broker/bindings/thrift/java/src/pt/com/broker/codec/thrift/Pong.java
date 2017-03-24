/**
 * Autogenerated by Thrift
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 */
package pt.com.broker.codec.thrift;

import java.util.Collections;
import java.util.EnumMap;
import java.util.EnumSet;
import java.util.HashMap;
import java.util.Map;

class Pong implements org.apache.thrift.TBase<Pong, Pong._Fields>, java.io.Serializable, Cloneable
{
	private static final org.apache.thrift.protocol.TStruct STRUCT_DESC = new org.apache.thrift.protocol.TStruct("Pong");

	private static final org.apache.thrift.protocol.TField ACTION_ID_FIELD_DESC = new org.apache.thrift.protocol.TField("action_id", org.apache.thrift.protocol.TType.STRING, (short) 1);

	public String action_id;

	/** The set of fields this struct contains, along with convenience methods for finding and manipulating them. */
	public enum _Fields implements org.apache.thrift.TFieldIdEnum
	{
		ACTION_ID((short) 1, "action_id");

		private static final Map<String, _Fields> byName = new HashMap<String, _Fields>();

		static
		{
			for (_Fields field : EnumSet.allOf(_Fields.class))
			{
				byName.put(field.getFieldName(), field);
			}
		}

		/**
		 * Find the _Fields constant that matches fieldId, or null if its not found.
		 */
		public static _Fields findByThriftId(int fieldId)
		{
			switch (fieldId)
			{
			case 1: // ACTION_ID
				return ACTION_ID;
			default:
				return null;
			}
		}

		/**
		 * Find the _Fields constant that matches fieldId, throwing an exception if it is not found.
		 */
		public static _Fields findByThriftIdOrThrow(int fieldId)
		{
			_Fields fields = findByThriftId(fieldId);
			if (fields == null)
				throw new IllegalArgumentException("Field " + fieldId + " doesn't exist!");
			return fields;
		}

		/**
		 * Find the _Fields constant that matches name, or null if its not found.
		 */
		public static _Fields findByName(String name)
		{
			return byName.get(name);
		}

		private final short _thriftId;
		private final String _fieldName;

		_Fields(short thriftId, String fieldName)
		{
			_thriftId = thriftId;
			_fieldName = fieldName;
		}

		public short getThriftFieldId()
		{
			return _thriftId;
		}

		public String getFieldName()
		{
			return _fieldName;
		}
	}

	// isset id assignments

	public static final Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> metaDataMap;
	static
	{
		Map<_Fields, org.apache.thrift.meta_data.FieldMetaData> tmpMap = new EnumMap<_Fields, org.apache.thrift.meta_data.FieldMetaData>(_Fields.class);
		tmpMap.put(_Fields.ACTION_ID, new org.apache.thrift.meta_data.FieldMetaData("action_id", org.apache.thrift.TFieldRequirementType.DEFAULT, new org.apache.thrift.meta_data.FieldValueMetaData(org.apache.thrift.protocol.TType.STRING)));
		metaDataMap = Collections.unmodifiableMap(tmpMap);
		org.apache.thrift.meta_data.FieldMetaData.addStructMetaDataMap(Pong.class, metaDataMap);
	}

	public Pong()
	{
	}

	public Pong(String action_id)
	{
		this();
		this.action_id = action_id;
	}

	/**
	 * Performs a deep copy on <i>other</i>.
	 */
	public Pong(Pong other)
	{
		if (other.isSetAction_id())
		{
			this.action_id = other.action_id;
		}
	}

	public Pong deepCopy()
	{
		return new Pong(this);
	}

	@Override
	public void clear()
	{
		this.action_id = null;
	}

	public String getAction_id()
	{
		return this.action_id;
	}

	public Pong setAction_id(String action_id)
	{
		this.action_id = action_id;
		return this;
	}

	public void unsetAction_id()
	{
		this.action_id = null;
	}

	/** Returns true if field action_id is set (has been assigned a value) and false otherwise */
	public boolean isSetAction_id()
	{
		return this.action_id != null;
	}

	public void setAction_idIsSet(boolean value)
	{
		if (!value)
		{
			this.action_id = null;
		}
	}

	public void setFieldValue(_Fields field, Object value)
	{
		switch (field)
		{
		case ACTION_ID:
			if (value == null)
			{
				unsetAction_id();
			}
			else
			{
				setAction_id((String) value);
			}
			break;

		}
	}

	public Object getFieldValue(_Fields field)
	{
		switch (field)
		{
		case ACTION_ID:
			return getAction_id();

		}
		throw new IllegalStateException();
	}

	/** Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise */
	public boolean isSet(_Fields field)
	{
		if (field == null)
		{
			throw new IllegalArgumentException();
		}

		switch (field)
		{
		case ACTION_ID:
			return isSetAction_id();
		}
		throw new IllegalStateException();
	}

	@Override
	public boolean equals(Object that)
	{
		if (that == null)
			return false;
		if (that instanceof Pong)
			return this.equals((Pong) that);
		return false;
	}

	public boolean equals(Pong that)
	{
		if (that == null)
			return false;

		boolean this_present_action_id = true && this.isSetAction_id();
		boolean that_present_action_id = true && that.isSetAction_id();
		if (this_present_action_id || that_present_action_id)
		{
			if (!(this_present_action_id && that_present_action_id))
				return false;
			if (!this.action_id.equals(that.action_id))
				return false;
		}

		return true;
	}

	@Override
	public int hashCode()
	{
		return 0;
	}

	public int compareTo(Pong other)
	{
		if (!getClass().equals(other.getClass()))
		{
			return getClass().getName().compareTo(other.getClass().getName());
		}

		int lastComparison = 0;
		Pong typedOther = (Pong) other;

		lastComparison = Boolean.valueOf(isSetAction_id()).compareTo(typedOther.isSetAction_id());
		if (lastComparison != 0)
		{
			return lastComparison;
		}
		if (isSetAction_id())
		{
			lastComparison = org.apache.thrift.TBaseHelper.compareTo(this.action_id, typedOther.action_id);
			if (lastComparison != 0)
			{
				return lastComparison;
			}
		}
		return 0;
	}

	public _Fields fieldForId(int fieldId)
	{
		return _Fields.findByThriftId(fieldId);
	}

	public void read(org.apache.thrift.protocol.TProtocol iprot) throws org.apache.thrift.TException
	{
		org.apache.thrift.protocol.TField field;
		iprot.readStructBegin();
		while (true)
		{
			field = iprot.readFieldBegin();
			if (field.type == org.apache.thrift.protocol.TType.STOP)
			{
				break;
			}
			switch (field.id)
			{
			case 1: // ACTION_ID
				if (field.type == org.apache.thrift.protocol.TType.STRING)
				{
					this.action_id = iprot.readString();
				}
				else
				{
					org.apache.thrift.protocol.TProtocolUtil.skip(iprot, field.type);
				}
				break;
			default:
				org.apache.thrift.protocol.TProtocolUtil.skip(iprot, field.type);
			}
			iprot.readFieldEnd();
		}
		iprot.readStructEnd();

		// check for required fields of primitive type, which can't be checked in the validate method
		validate();
	}

	public void write(org.apache.thrift.protocol.TProtocol oprot) throws org.apache.thrift.TException
	{
		validate();

		oprot.writeStructBegin(STRUCT_DESC);
		if (this.action_id != null)
		{
			oprot.writeFieldBegin(ACTION_ID_FIELD_DESC);
			oprot.writeString(this.action_id);
			oprot.writeFieldEnd();
		}
		oprot.writeFieldStop();
		oprot.writeStructEnd();
	}

	@Override
	public String toString()
	{
		StringBuilder sb = new StringBuilder("Pong(");
		boolean first = true;

		sb.append("action_id:");
		if (this.action_id == null)
		{
			sb.append("null");
		}
		else
		{
			sb.append(this.action_id);
		}
		first = false;
		sb.append(")");
		return sb.toString();
	}

	public void validate() throws org.apache.thrift.TException
	{
		// check for required fields
	}

	private void writeObject(java.io.ObjectOutputStream out) throws java.io.IOException
	{
		try
		{
			write(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(out)));
		}
		catch (org.apache.thrift.TException te)
		{
			throw new java.io.IOException(te);
		}
	}

	private void readObject(java.io.ObjectInputStream in) throws java.io.IOException, ClassNotFoundException
	{
		try
		{
			read(new org.apache.thrift.protocol.TCompactProtocol(new org.apache.thrift.transport.TIOStreamTransport(in)));
		}
		catch (org.apache.thrift.TException te)
		{
			throw new java.io.IOException(te);
		}
	}

}