const express = require("express");
const bodyParser = require("body-parser");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(bodyParser.json());
app.use(cors());

// Connect to MongoDB
// mongoose.connect('mongodb://localhost:27017/NewDocket', { useNewUrlParser: true, useUnifiedTopology: true });

// Define your MongoDB schema and model here using mongoose
const { Schema } = mongoose;

const userSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  mobile: {
    type: Number,
    required: true,
    unique: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: true,
  },
});

const productSchema = new Schema({
  name: {
    type: String,
    required: true,
  },
  desc: {
    type: String,
    required: true,
  },
  price: {
    type: Number,
    required: true,
  },
  color: {
    type: String,
    required: true,
  },
  image: {
    type: String,
    required: true,
  },
});

const User = mongoose.model("User", userSchema);
const Product = mongoose.model("Product", productSchema);

// Define your API routes here
app.get("/check", (req, res) => {
  res.send("Running Successfully!");
});

app.get("/api/get/products", async (req, res) => {
  // Connect to MongoDB
  try {
    await mongoose
      .connect(process.env.MongoDB_URI)
      .then(() => {})
      .catch((err) => {});

    const products = { products: await Product.find({}) };

    res.status(200).json(products);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    // Ensures that the client will close when you finish/error
    await mongoose.disconnect();
  }
});

app.post("/api/register", async (req, res) => {
  try {
    await mongoose
      .connect(process.env.MongoDB_URI)
      .then(() => {})
      .catch((err) => {});

    // Extract email and password from the request body
    const { name, mobile, email, password } = req.body;

    // Check if the email already exists
    const existingEmailUser = await User.findOne({ email });
    if (existingEmailUser) {
      mongoose.disconnect();
      return res.status(400).json({ message: "Email already exists" });
    }
    // Check if the mobile already exists
    const existingMobileUser = await User.findOne({ mobile });
    if (existingMobileUser) {
      mongoose.disconnect();
      return res.status(400).json({ message: "Mobile already exists" });
    }

    // Create a new user
    const newUser = new User({ name, mobile, email, password });

    // Save the user to the database
    await newUser.save();

    // Respond with a success message
    res.status(201).json({ message: "User registered successfully" });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: "Internal server error" });
  } finally {
    // Close the database connection
    mongoose.disconnect();
  }
});

app.listen(PORT, () => {});
